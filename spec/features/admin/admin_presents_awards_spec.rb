require "rails_helper"

RSpec.feature "admin presents awards" do
  let(:admin) { create :admin_user }
  let(:team) { create :team, vote_threshold: 5 }
  let(:ten_votes_nomination) { create :nomination, body: "Receives 10 Votes", team: team }
  let(:three_votes_nomination) { create :nomination, body: "Receives 3 Votes", team: team }
  let(:no_votes_nomination) { create :nomination, body: "Receives No Votes", team: team }
  let(:non_team_nomination) { create :nomination, body: "Doesn't Belong Here" }

  describe "signed in admin" do
    it "presents the awards, respecting the vote threshold" do
      10.times { FactoryGirl.create(:vote, nomination: ten_votes_nomination) }
      6.times { FactoryGirl.create(:vote, nomination: non_team_nomination) }
      3.times { FactoryGirl.create(:vote, nomination: three_votes_nomination) }
      sign_in(admin)
      visit team_awards_path(team)

      expect(page).to have_content "Weekly Awards for #{team.name}"
      expect(page).to have_content "Receives 10 Votes"
      expect(page).to_not have_content "Receives 3 Votes"
      expect(page).to_not have_content "Receives No Votes"
      expect(page).to_not have_content "Doesn't Belong Here"
    end
  end

  describe "signed in non-admin user" do
    it "redirects user with non-authorization warning" do
      sign_in(FactoryGirl.create(:user))
      visit team_awards_path(team)

      expect(page).to have_current_path(root_path)
      expect(page).to have_content "You are not authorized to access this content."
    end
  end

  describe "guest user" do
    it "redirects user with sign-in required warning" do
      visit team_awards_path(team)

      expect(page).to have_current_path(root_path)
      expect(page).to have_content "You need to sign in before continuing."
    end
  end
end
