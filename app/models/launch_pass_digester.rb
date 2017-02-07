class LaunchPassDigester

  def initialize(auth_hash, user)
    @info = auth_hash["info"]
    @launch_pass_id = auth_hash["uid"]
    @teams = @info["teams"]
    @user = user
  end

  def digest
    update_user!
    update_user_teams!
  end

  private

  attr_reader :info, :launch_pass_id, :teams, :user

  def new_team_ids
    payload_team_ids - user_team_ids
  end

  def payload_team_ids
    payload_teams.keys
  end

  def payload_teams
    payload_teams = Hash.new
    teams.each { |team| payload_teams[team["id"]] = team["name"] }
    payload_teams
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
