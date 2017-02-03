class SessionsController < ApplicationController

  def create
    user_hash = request.env["omniauth.auth"].slice("uid", "info", "extra")
    existing_user = User.find_by(github_uid: user_hash["uid"])
    if existing_user.nil?
      user = new_user_from_github(user_hash)
    else
      user = updated_user_from_github(existing_user, user_hash)
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

  protected

  def new_user_from_github(user_hash)
    User.new(
        email: user_hash["info"]["email"],
        github_uid: user_hash["uid"],
        image_url: user_hash["extra"]["raw_info"]["avatar_url"],
        name: user_hash["info"]["name"],
        sign_in_count: 1)
  end

  def updated_user_from_github(user, user_hash)
    user.assign_attributes(
      email: user_hash["info"]["email"],
      image_url: user_hash["extra"]["raw_info"]["avatar_url"],
      name: user_hash["info"]["name"])
    user.increment :sign_in_count
    user
  end

end
