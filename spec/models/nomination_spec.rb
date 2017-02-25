require "rails_helper"

describe Nomination, type: :model do
  subject { create(:nomination) }

  it { should belong_to(:nominator) }
  it { should belong_to(:nominee) }
  it { should belong_to(:team) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(160) }

  describe "validates nominator/nominee are not the same" do
    let(:user) { create(:user) }
    let(:different_user) { create(:user) }
    let(:nomination) { create(:nomination, nominator: user, nominee: different_user) }

    it "accepts differing nominator/nominee" do
      expect(nomination.valid?).to be(true)
    end

    it "rejects identical nominator/nominee" do
      nomination.nominator = user
      nomination.nominee = user
      expect(nomination.valid?).to be(false)
    end
  end

  describe "validates nominator/nominee belong to team (or are admins)" do
    let(:admin) { create(:admin_user) }
    let(:non_team_user) { create(:user) }
    let(:nomination) { create(:nomination) }

    it "accepts admin nominators" do
      nomination.nominator = admin
      expect(nomination.valid?).to be(true)
    end

    it "rejects non-team nominators" do
      nomination.nominator = non_team_user
      expect(nomination.valid?).to be(false)
    end

    it "accepts admin nominees" do
      nomination.nominee = admin
      expect(nomination.valid?).to be(true)
    end

    it "rejects non-team nominees" do
      nomination.nominee = non_team_user
      expect(nomination.valid?).to be(false)
    end
  end

  describe "validates nominator and nominee are not the same" do
    let(:user) { create(:user) }
    let(:nomination) { create(:nomination, nominator: user) }

    it "rejects self-nominations" do
      nomination.nominee = user
      expect(nomination.valid?).to be(false)
    end
  end
end
