class TeamSelectorController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.teams - [Team.admins]
  end
end
