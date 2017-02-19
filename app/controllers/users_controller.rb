class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(handle: params[:id])
    @awards = Nomination.unscoped.where(nominee: @user).by_votes(1)
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
