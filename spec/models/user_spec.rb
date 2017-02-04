require "rails_helper"

describe User, type: :model do
  subject { create(:user) }
  auth_hash =
    { "info" =>
      { "nickname" => "Laura2theLetter",
        "image"  => "http://imgur.com",
        "name"   => "Laura Hollis"
      }
    }

  it { should have_valid(:email).when("something@example.com", "another@something.com") }
  it { should_not have_valid(:email).when("bad", ".com", "bad@com", "bad.com") }

  it { should validate_presence_of(:image_url) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:github_id) }
  it { should validate_uniqueness_of(:handle) }

  describe "self#new_from_github" do
    it "instantiates a new user" do
      auth_hash["uid"] = "12345"
      user = User.new_from_github(auth_hash)

      expect(user).to be_a(User)
      expect(user.handle).to eq("Laura2theLetter")
      expect(user.image_url).to eq("http://imgur.com")
      expect(user.name).to eq("Laura Hollis")
      expect(user.new_record?).to be(true)
    end
  end

  describe "#update_from_github" do
    let(:user) { create(:user) }

    it "updates the correct attributes" do
      auth_hash["uid"] = user.github_id
      original_user_sign_in_count = user.sign_in_count

      expect(user.update_from_github(auth_hash)).to be_a(User)
      expect(user.handle).to eq("Laura2theLetter")
      expect(user.image_url).to eq("http://imgur.com")
      expect(user.name).to eq("Laura Hollis")
      expect(user.persisted?).to be(true)
    end
  end
end
