require "rails_helper"

describe Team, type: :model do
  subject { create(:team) }

  it { should have_many(:memberships) }
  it { should have_many(:nominations) }
  it { should have_many(:members) }

  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:vote_threshold).is_greater_than(0).only_integer }
  it { should validate_uniqueness_of(:launch_pass_id) }

  describe "#users" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let!(:membership) { create(:membership, team: team, user: user) }
    let!(:non_team_member) { create(:user) }
    let!(:admin) { create(:admin_user) }

    it "returns team members" do
      expect(team.users).to include(user)
    end

    it "returns admin users" do
      expect(team.users).to include(admin)
    end

    it "does not return non team members" do
      expect(team.users).to_not include(non_team_member)
    end
  end
end
