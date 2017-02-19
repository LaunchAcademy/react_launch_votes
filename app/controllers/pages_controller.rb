class PagesController < ApplicationController

  def index
    if user_signed_in?
      unless current_user.launch_pass_id.nil?
        if current_user.teams.count == 1
          redirect_to team_nominations_path(current_user.teams.first)
        elsif !current_user.default_team.nil?
          redirect_to team_nominations_path(current_user.default_team)
        else
          redirect_to team_selector_path
        end
      end
    end
  end

end
