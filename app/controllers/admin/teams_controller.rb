class Admin::TeamsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @teams = Team.order(:name)
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:success] = "Team settings updated successfully."
      redirect_to admin_teams_path
    else
      flash[:alert] = "There was a problem updating team settings."
      render :show
    end
  end

  private

  def team_params
    params.require(:team).permit(:active, :vote_threshold)
  end
end
