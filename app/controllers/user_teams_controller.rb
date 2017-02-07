class UserTeamsController < ApplicationController
  before_action :authenticate_user!

  def edit
    auth_hash = session[:auth]
    if LaunchPassDigester.new(auth_hash, current_user).digest
      flash[:success] = "LaunchPass account linked successfully."
    else
      flash[:alert] = "There was a problem linking your LaunchPass account."
    end
    session.delete(:auth)
    redirect_to root_path
  end

end
