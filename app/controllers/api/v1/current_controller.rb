class Api::V1::CurrentController < Api::ApiController

  def index
    render json: current_user, serializer: CurrentUserSerializer
  end

end
