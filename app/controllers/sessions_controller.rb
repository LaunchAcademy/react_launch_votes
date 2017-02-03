class SessionsController < ApplicationController

  def create
    auth_hash = request.env["omniauth.auth"].slice("uid", "info", "extra")
    existing_user = User.find_by(github_uid: auth_hash["uid"])
    if existing_user.nil?
      user = User.new_from_github(auth_hash)
    else
      user = existing_user.update_from_github(auth_hash)
    end
    if user.save
      sign_in(user)
      flash[:success] = "Signed in as #{user.name}."
    else
      sign_out
      flash[:alert] = "There was a problem signing in."
    end
    redirect_to root_path
  end

end
