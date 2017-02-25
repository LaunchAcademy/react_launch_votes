require "rails_helper"

describe Vote, type: :model do
  subject { create(:vote) }

  it { should belong_to(:nomination).counter_cache(true) }
  it { should belong_to(:user) }
end
