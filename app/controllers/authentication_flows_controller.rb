class AuthenticationFlowsController < ApplicationController

  def create
    auth_hash = request.env["omniauth.auth"].slice("provider", "uid", "info")
    if auth_hash["provider"] == "github"
      session[:auth] = auth_hash
      redirect_to new_session_path
    elsif auth_hash["provider"] == "launch_pass"
      if user_signed_in?
        session[:auth] = auth_hash
        redirect_to edit_user_team_path(current_user)
      else
        flash[:alert] = "You must be signed in to link your LaunchPass account."
        redirect_to root_path
      end
    end
  end

end
