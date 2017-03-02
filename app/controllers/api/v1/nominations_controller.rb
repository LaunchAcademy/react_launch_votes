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

  def destroy
    nomination = Nomination.find(params[:id])
    if authorize_nomination_owner_or_admin(nomination)
      if nomination.destroy
        render json: nomination
      else
        render_object_errors(nomination)
      end
    else
      render json: { errors: ["Forbidden"] }, status: :forbidden
    end
  end

  def show
    nomination = Nomination.find(params[:id])
    if authorize_nomination_owner_or_admin(nomination)
      render json: nomination
    else
      render json: { errors: ["Forbidden"] }, status: :forbidden
    end
  end

  def update
    nomination = Nomination.find(params[:id])
    if authorize_nomination_owner_or_admin(nomination)
      if nomination.update(update_params)
        render json: nomination.team
      else
        render_object_errors(nomination)
      end
    else
      render json: { errors: ["Forbidden"] }, status: :forbidden
    end
  end

  def authorize_nomination_owner_or_admin(nomination)
    current_user == nomination.nominator || current_user.admin?
  end

  private

  def create_params
    params.require(:nomination).permit(:body, :nominee_id)
  end

  def update_params
    params.require(:nomination).permit(:body)
  end

end
