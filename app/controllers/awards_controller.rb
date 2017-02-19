class AwardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @team = Team.find(params[:team_id])
    @awards = Nomination.unscoped.where(team: @team).current_week.by_votes(@team.vote_threshold)
  end
end
