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

  def new_product_offering_ids
    payload_product_offering_ids - user_team_ids
  end

  def new_team_ids
    payload_team_ids - user_team_ids
  end

  def payload_product_offering_ids
    payload_product_offerings.keys
  end

  def payload_team_ids
    payload_teams.keys
  end

  def payload_product_offerings
    payload_product_offerings = Hash.new
    product_offerings.each do |product_offering|
      if product_offering["location"]
        product_offering_name = "#{product_offering['location'].titleize} #{product_offering['name']}"
        payload_product_offerings[product_offering["id"]] = product_offering_name
      else
        payload_product_offerings[product_offering["id"]] = product_offering["name"]
      end
    end
    payload_product_offerings
  end

  def payload_teams
    payload_teams = Hash.new
    teams.each { |team| payload_teams[team["id"]] = team["name"] }
    payload_teams
  end

  def update_user_product_offerings!
    updated_product_offerings.each do |product_offering|
      membership = Membership.find_or_initialize_by(team: product_offering, user: user)
      membership.save unless membership.persisted?
    end
  end

  def update_user!
    if user.launch_pass_id.nil?
      user.update(email: info["email"], launch_pass_id: launch_pass_id)
    else
      user.update(email: info["email"])
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
    new_product_offering_ids.each do |id|
      product_offering = Team.find_or_initialize_by(launch_pass_id: id)
      product_offering.name = payload_product_offerings[id]
      product_offering.save
      updated_product_offerings << product_offering
    end
    updated_product_offerings
  end

  def updated_teams
    updated_teams = Array.new
    new_team_ids.each do |id|
      team = Team.find_or_initialize_by(launch_pass_id: id)
      team.name = payload_teams[id]
      team.save
      updated_teams << team
    end
    updated_teams
  end

  def user_team_ids
    user.teams.map(&:id)
  end

end
