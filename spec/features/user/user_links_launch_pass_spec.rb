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
      expect(user.name).to eq("S. LaFontaine")
      expect(user.launch_pass_id).to eq(9999)
    end

    it "creates teams that do not exist" do
      team = Team.new(launch_pass_id: 123456789, name: "TheMachine")
      sign_in(user)
      link_launch_pass({uid: "9998", email: "harold_finch@teammachine.org", first_name: "Harold", last_name: "Finch", teams: [team]})

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.name).to eq("Harold Finch")
      expect(user.teams.first.name).to eq("TheMachine")
      expect(user.teams.first.launch_pass_id).to eq(123456789)
    end

    it "creates memberships for teams that do exist" do
      sign_in(user)
      link_launch_pass({uid: "9997", email: "john_reese@teammachine.org", first_name: "John", last_name: "Reese", teams: [first_team, second_team]})

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.name).to eq("John Reese")
      expect(user.teams.first.name).to eq("Root")
      expect(user.teams.second.name).to eq("Samaritan")
    end

    it "updates attributes for teams that already exist" do
      sign_in(user)
      link_launch_pass({uid: "9997", email: "john_reese@teammachine.org", first_name: "John", last_name: "Reese", teams: [first_team, second_team]})
      first_team.update(name: "Jack")
      second_team.update(name: "Sally")
      link_launch_pass({uid: "9997", email: "the_pumpkin_king@thisishalloween.com", first_name: "Jack", last_name: "Skellington", teams: [first_team, second_team]})

      user.reload
      expect(page).to have_content "LaunchPass account linked"
      expect(user.name).to eq("Jack Skellington")
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
