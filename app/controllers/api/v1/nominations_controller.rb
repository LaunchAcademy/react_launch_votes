class Api::V1::NominationsController < Api::ApiController

  def create
    team = Team.find(params[:team_id])
    nomination = Nomination.new(create_params)
    nomination.team = team
    nomination.nominator = current_user
    if nomination.save
      render json: nomination
    else
      render_object_errors(nomination)
    end
  end

  def show
    nomination = Nomination.find(params[:id])
    render json: nomination
  end

  def update
    nomination = Nomination.find(params[:id])
    if nomination.update(update_params)
      render json: nomination.team
    else
      render_object_errors(nomination)
    end
  end

  private

  def create_params
    params.require(:nomination).permit(:body, :nominee_id)
  end

  def update_params
    params.require(:nomination).permit(:body)
  end

end
