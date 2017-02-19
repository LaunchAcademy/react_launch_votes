class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(handle: params[:id])
    @awards = Nomination.unscoped.where(nominee: @user).by_votes(1)
  end
end
