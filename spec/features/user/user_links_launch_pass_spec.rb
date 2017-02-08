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

    it "updates attributes for teams that already exist" do
      sign_in(user)
      link_launch_pass("9997", "john_reese@teammachine.org", [first_team, second_team])
      first_team.update(name: "Jack")
      second_team.update(name: "Sally")
      link_launch_pass("9997", "the_pumpkin_king@thisishalloween.com", [first_team, second_team])

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.teams.first.name).to eq("Jack")
      expect(user.teams.second.name).to eq("Sally")
      expect(user.email).to eq("the_pumpkin_king@thisishalloween.com")
    end
  end

  describe "unsuccessfully" do
    it "fails if the user is not signed in" do
      link_launch_pass

      expect(page).to have_content "You must be signed in to link your LaunchPass account"
    end

    it "requires the user to sign in" do
      visit edit_user_team_path(user)

      expect(page).to have_content "You need to sign in before continuing"
    end
  end
end
