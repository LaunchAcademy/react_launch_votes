class Api::ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def render_object_errors(object)
    render json: { errors: object.errors.full_messages }, status: 422
  end
end
