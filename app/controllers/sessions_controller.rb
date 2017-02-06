class SessionsController < ApplicationController
  before_action :prevent_duplicate_sign_in, only: :new

  def new
    auth_hash = session[:auth]
    existing_user = User.find_by(github_id: auth_hash["uid"])
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
    session.delete(:auth)
    redirect_to root_path
  end

  def destroy
    sign_out
    flash[:success] = "Signed out."
    redirect_to root_url
  end

end
