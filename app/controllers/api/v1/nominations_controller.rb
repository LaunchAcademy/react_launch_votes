class Api::V1::NominationsController < Api::ApiController

  def create
    team = Team.find(params[:team_id])
    nomination = Nomination.new(create_params)
    nomination.team = team
    nomination.nominator = current_user
    if nomination.save
      render json: nomination
    else
      render json: { error: nomination.errors.full_messages }, status: 422
    end
  end

  def index
    render json: Team.find(params[:team_id]).nominations.as_json
  end

  private

  def create_params
    params.require(:nomination).permit(:body, :nominee_id)
  end

end
