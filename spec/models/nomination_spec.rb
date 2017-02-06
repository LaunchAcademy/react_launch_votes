require "rails_helper"

describe Nomination, type: :model do
  subject { create(:nomination) }

  it { should belong_to(:nominator) }
  it { should belong_to(:nominee) }
  it { should belong_to(:team) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:nominator) }
  it { should validate_presence_of(:nominee) }
  it { should validate_presence_of(:team) }
end
