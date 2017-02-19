require "rails_helper"

describe Team, type: :model do
  subject { create(:team) }

  it { should have_many(:memberships) }
  it { should have_many(:nominations) }
  it { should have_many(:members) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:launch_pass_id) }
end
