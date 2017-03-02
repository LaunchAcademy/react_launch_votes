class Api::V1::TeamsController < Api::ApiController

  def show
    team = Team.find(params[:id])
    if authorize_team_member_or_admin(team)
      render json: { errors: ["Forbidden"] }, status: :forbidden
    else
      render json: team
    end
  end

  def authorize_team_member_or_admin(team)
    !current_user.teams.include?(team) && !current_user.admin?
  end

end
