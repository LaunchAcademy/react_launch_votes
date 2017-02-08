class Api::V1::NominationsController < Api::ApiController

  def index
    render json: Team.find(params[:team_id]).nominations.as_json
  end

end
