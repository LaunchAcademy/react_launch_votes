class Api::V1::CurrentController < Api::ApiController

  def index
    if user_signed_in?
      render json: current_user, serializer: CurrentUserSerializer
    else
      render json: {id: :null}
    end
  end

end
