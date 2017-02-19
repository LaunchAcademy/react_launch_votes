class TeamSelectorController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @teams = Team.active
    else
      @teams = current_user.teams
    end
  end
end
