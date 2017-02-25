require "rails_helper"

describe Membership, type: :model do
  subject { create(:membership) }

  it { should belong_to(:team) }
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:team_id).scoped_to(:user_id) }
end
