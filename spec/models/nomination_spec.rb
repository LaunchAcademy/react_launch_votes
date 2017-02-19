require "rails_helper"

describe Nomination, type: :model do
  subject { create(:nomination) }

  it { should belong_to(:nominator) }
  it { should belong_to(:nominee) }
  it { should belong_to(:team) }

  it { should validate_presence_of(:body) }

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
end
