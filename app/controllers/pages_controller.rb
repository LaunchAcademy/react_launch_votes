class PagesController < ApplicationController

  def index
    if user_signed_in?
      unless current_user.launch_pass_id.nil?
        redirect_to team_nominations_path(1)
      end
    end
  end

end
