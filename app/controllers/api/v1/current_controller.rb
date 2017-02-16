class Api::V1::CurrentController < Api::ApiController

  def index
    if user_signed_in?
      render json: current_user
    else
      render json: {id: :null}
    end
  end

end
