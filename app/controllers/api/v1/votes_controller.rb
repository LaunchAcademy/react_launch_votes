class Api::V1::VotesController < Api::ApiController
  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
    if vote.save
      render json: vote.nomination
    else
      render json: { errors: nomination.errors.full_messages }, status: 422
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:nomination_id)
  end
end
