class Api::V1::TeamsController < Api::ApiController

  def show
    team = Team.find(params[:id])
    if authorize_team_member_or_admin(team)
      render json: team
    else
      render json: { errors: ["Forbidden"] }, status: :forbidden
    end
  end

  def authorize_team_member_or_admin(team)
    current_user.teams.include?(team) || current_user.admin?
  end

end
