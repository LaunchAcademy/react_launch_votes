class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(handle: params[:id])
    user_team = @user.current_team
    vote_threshold = user_team.present? ? user_team.vote_threshold : 1
    @awards = Nomination.unscoped.where(archived: false, nominee: @user).where("votes_count >= ?", vote_threshold).previous_weeks.order(votes_count: :desc).limit(5)
  end

  def update
    @user = User.find_by(handle: params[:id])
    if @user == current_user
      if @user.update(update_params)
        flash[:success] = "Default team set successfully."
      else
        flash[:alert] = "There was a problem setting your default team."
      end
    else
      flash[:alert] = "You are not authorized to edit this user."
    end
    redirect_to user_path(@user)
  end

  private

  def update_params
    params.require(:user).permit(:default_team_id)
  end

end
