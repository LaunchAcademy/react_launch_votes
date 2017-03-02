class LaunchPassDigester

  def initialize(auth_hash, user)
    @info = auth_hash["info"]
    @launch_pass_id = auth_hash["uid"]
    @product_offerings = @info["product_offerings"]
    @teams = @info["teams"]
    @user = user
  end

  def digest
    update_user!
    update_user_product_offerings!
    update_user_teams!
  end

  private

  attr_reader :info, :launch_pass_id, :product_offerings, :teams, :user

  def payload_product_offerings
    payload_product_offerings = Array.new
    product_offerings.each do |product_offering|
      if product_offering["location"].present?
        product_offering_name = "#{product_offering['location'].titleize} #{product_offering['name']}"
        payload_product_offerings << product_offering_name
      else
        payload_product_offerings << product_offering["name"]
      end
    end
    payload_product_offerings
  end

  def payload_teams
    payload_teams = Array.new
    teams.each { |team| payload_teams << team["name"] }
    payload_teams
  end

  def update_user_product_offerings!
    updated_product_offerings.each do |product_offering|
      membership = Membership.find_or_initialize_by(team: product_offering, user: user)
      membership.save unless membership.persisted?
    end
  end

  def update_user!
    user_name = "#{info['first_name']} #{info['last_name']}"
    if user.launch_pass_id.nil?
      user.update(email: info["email"], launch_pass_id: launch_pass_id, name: user_name)
    else
      user.update(email: info["email"], name: user_name)
    end
  end

  def update_user_teams!
    updated_teams.each do |team|
      membership = Membership.find_or_initialize_by(team: team, user: user)
      membership.save unless membership.persisted?
    end
  end

  def updated_product_offerings
    updated_product_offerings = Array.new
    payload_product_offerings.each do |name|
      product_offering = Team.find_or_initialize_by(name: name)
      product_offering.save unless product_offering.persisted?
      updated_product_offerings << product_offering
    end
    updated_product_offerings
  end

  def updated_teams
    updated_teams = Array.new
    payload_teams.each do |name|
      team = Team.find_or_initialize_by(name: name)
      team.save unless team.persisted?
      updated_teams << team
    end
    updated_teams
  end
end
