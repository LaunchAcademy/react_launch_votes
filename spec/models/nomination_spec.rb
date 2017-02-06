require "rails_helper"

describe Nomination, type: :model do
  subject { create(:nomination) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:nominator) }
  it { should validate_presence_of(:nominee) }
end
