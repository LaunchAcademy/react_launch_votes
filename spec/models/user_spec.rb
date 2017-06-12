require "rails_helper"

describe User, type: :model do
  subject { create(:user) }
  github_auth_hash =
    { "info" =>
      { "nickname" => "Laura2theLetter",
        "image"  => "http://imgur.com",
        "name"   => "Laura Hollis"
      }
    }

  it { should have_many(:nominations) }
  it { should have_many(:memberships) }
  it { should have_many(:teams) }

  it { should have_valid(:email).when("something@example.com", "another@something.com") }
  it { should_not have_valid(:email).when("bad", ".com", "bad@com", "bad.com") }

  it { should have_valid(:image_url).when("https://avatars.githubusercontent.com/u/1234567?v=1", "http://avatars.githubusercontent.com/u/1234567?v=2") }
  it { should_not have_valid(:image_url).when("avatars.githubusercontent.com", "", nil) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:github_id) }
  it { should validate_uniqueness_of(:handle) }

  describe "self#new_from_github" do
    it "instantiates a new user" do
      github_auth_hash["uid"] = 12345
      user = User.new_from_github(github_auth_hash)

      expect(user).to be_a(User)
      expect(user.github_id).to eq(12345)
      expect(user.handle).to eq("Laura2theLetter")
      expect(user.image_url).to eq("http://imgur.com")
      expect(user.name).to eq("Laura Hollis")
      expect(user.new_record?).to be(true)
    end
  end

  describe "#admin?" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:admin_user) }

    it "returns true for admin users" do
      expect(admin_user.admin?).to be(true)
    end

    it "returns false for non-admin users" do
      expect(user.admin?).to be(false)
    end
  end

  describe "#update_from_github" do
    let(:user) { create(:user) }

    it "updates the correct attributes" do
      github_auth_hash["uid"] = user.github_id

      expect(user.update_from_github(github_auth_hash)).to be_a(User)
      expect(user.handle).to eq("Laura2theLetter")
      expect(user.image_url).to eq("http://imgur.com")
      expect(user.persisted?).to be(true)
    end
  end
end
