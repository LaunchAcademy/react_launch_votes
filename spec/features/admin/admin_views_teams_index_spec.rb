require "rails_helper"

RSpec.feature "admin views teams index" do
  let(:admin) { create :admin_user }
  let(:user) { create :user }
  let!(:team1) { create :team, name: "What I Should Have Said Was Nothing" }
  let!(:team2) { create :team, name: "My Girlfriend's Boyfriend" }
  let!(:team3) { create :team, name: "Thank God For Jokes" }

  describe "signed in admin" do
    it "returns an index of teams in the database" do
      sign_in(admin)
      visit admin_teams_path

      expect(page).to have_link "Admin", href: admin_team_path(admin.teams.first)
      expect(page).to have_link "What I Should Have Said Was Nothing", href: admin_team_path(team1)
      expect(page).to have_link "My Girlfriend's Boyfriend", href: admin_team_path(team2)
      expect(page).to have_link "Thank God For Jokes", href: admin_team_path(team3)
    end
  end

  describe "signed in non-admin user" do
    it "redirects user with non-authorization warning" do
      sign_in(user)
      visit admin_teams_path

      expect(page).to have_current_path(root_path)
      expect(page).to have_content "You are not authorized to access this content."
      expect(page).to_not have_link "Admin", href: admin_team_path(admin.teams.first)
      expect(page).to_not have_link "What I Should Have Said Was Nothing", href: admin_team_path(team1)
    end
  end

  describe "guest user" do
    it "redirects user with sign-in required warning" do
      visit admin_teams_path

      expect(page).to have_current_path(root_path)
      expect(page).to have_content "You need to sign in before continuing."
      expect(page).to_not have_link "Admin", href: admin_team_path(admin.teams.first)
      expect(page).to_not have_link "What I Should Have Said Was Nothing", href: admin_team_path(team1)
    end
  end
end
