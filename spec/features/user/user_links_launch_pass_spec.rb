require "rails_helper"

RSpec.feature "user links LaunchPass account" do
  let(:user) { create :user }

  describe "successfully" do
    let(:first_team) { create :team, name: "Root" }
    let(:second_team) { create :team, name: "Samaritan" }

    it "updates the user" do
      sign_in(user)
      link_launch_pass

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.email).to eq("makewayforlaf@silasuniversity.edu")
      expect(user.launch_pass_id).to eq(9999)
    end

    it "creates teams that do not exist" do
      team = Team.new(launch_pass_id: 123456789, name: "TheMachine")
      sign_in(user)
      link_launch_pass("9998", "harold_finch@teammachine.org", [team])

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.teams.first.name).to eq("TheMachine")
      expect(user.teams.first.launch_pass_id).to eq(123456789)
    end

    it "creates memberships for teams that do exist" do
      sign_in(user)
      link_launch_pass("9997", "john_reese@teammachine.org", [first_team, second_team])

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.teams.first.name).to eq("Root")
      expect(user.teams.second.name).to eq("Samaritan")
    end
  end
end
