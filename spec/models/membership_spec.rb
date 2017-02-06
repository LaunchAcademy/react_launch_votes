require "rails_helper"

describe Membership, type: :model do
  subject { create(:membership) }

  it { should belong_to(:team) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:team) }
  it { should validate_presence_of(:user) }
end
