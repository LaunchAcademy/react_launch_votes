class Api::ApiController < ApplicationController
  before_action :authenticate_user_api!
  protect_from_forgery unless: -> { request.format.json? }

  def authenticate_user_api!
    if !user_signed_in?
      render json: { errors: "not authorized" }, status: :unauthorized
    end
  end

  def render_object_errors(object)
    render json: { errors: object.errors.full_messages }, status: :unprocessable_entity
  end
end
