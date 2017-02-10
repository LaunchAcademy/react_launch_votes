class Api::V1::TeamsController < Api::ApiController

  def show
    @team = Team.find(params[:id])
    render json: @team
  end

end
