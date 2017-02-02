class SessionsController < ApplicationController

  def create
    user = User.find_by(github_uid: request.env["omniauth.auth"]["uid"])
    if user.nil?
      new_user = User.new(
        email: request.env["omniauth.auth"]["info"]["email"],
        github_uid: request.env["omniauth.auth"]["uid"],
        image_url: request.env["omniauth.auth"]["extra"]["raw_info"]["avatar_url"],
        name: request.env["omniauth.auth"]["info"]["name"])
      if new_user.save
        sign_in(new_user)
        flash[:success] = "Signed in as #{new_user.name}."
      else
        sign_out
        flash[:alert] = "There was a problem signing in."
      end
    else
      if user.update(
        email: request.env["omniauth.auth"]["info"]["email"],
        image_url: request.env["omniauth.auth"]["extra"]["raw_info"]["avatar_url"],
        name: request.env["omniauth.auth"]["info"]["name"])
        user.increment! :sign_in_count
        sign_in(user)
        flash[:success] = "Signed in as #{user.name}."
      else
        sign_out
        flash[:alert] = "There was a problem signing in."
      end
    end
    redirect_to root_path
  end

end
