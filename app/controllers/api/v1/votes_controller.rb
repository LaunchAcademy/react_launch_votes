class Api::V1::VotesController < Api::ApiController

  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
    if vote.save
      render json: vote.nomination
    else
      render_object_errors(vote)
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    if vote.destroy
      render json: vote.nomination
    else
      render_object_errors(vote)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:nomination_id)
  end

end
