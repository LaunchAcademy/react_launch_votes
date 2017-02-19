require "rails_helper"

describe Membership, type: :model do
  subject { create(:membership) }

  it { should belong_to(:team) }
  it { should belong_to(:user) }
end
