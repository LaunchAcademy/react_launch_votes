require "rails_helper"

RSpec.feature "admin updates team settings" do
  let(:admin) { create :admin_user }
  let(:user) { create :user }
  let(:team) { create :team, name: "Boston Over 9,000" }

  describe "signed in admin" do
    it "updates the team's vote threshold attribute" do
      sign_in(admin)
      visit admin_team_path(team)
      fill_in "team_vote_threshold", with: 9000
      click_button "Save"

      expect(page).to have_content "Team settings updated successfully."
      team.reload
      expect(team.vote_threshold).to eq 9000
    end

    it "updates the team's active attribute" do
      sign_in(admin)
      visit admin_team_path(team)
      uncheck "team_active"
      click_button "Save"

      expect(page).to have_content "Team settings updated successfully."
      team.reload
      expect(team.active?).to be false
    end

    it "fails gracefully" do
      sign_in(admin)
      visit admin_team_path(team)
      fill_in "team_vote_threshold", with: -1
      click_button "Save"

      expect(page).to have_current_path(admin_team_path(team))
      expect(page).to have_content "There was a problem updating team settings."
      team.reload
      expect(team.vote_threshold).to eq 1
    end
  end
end
