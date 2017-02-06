class UserTeamsController < ApplicationController
  before_action :authenticate_user!

  def edit
    auth_hash = session[:auth]
    user = current_user.update_from_launch_pass(auth_hash)
    if user.save
      flash[:success] = "LaunchPass account linked successfully."
    else
      flash[:alert] = "There was a problem linking your LaunchPass account."
    end
    session.delete(:auth)
    redirect_to root_path
  end

end
