require "rails_helper"

RSpec.feature "user signs up" do
  before(:each) do
    sign_out
  end

  it "creates a new user" do
    expect{sign_up_user(474747)}.to change{User.count}.by(1)
  end

  it "starts a signed-in session" do
    sign_up_user

    expect(page).to have_content "Sign Out"
    expect(page).to have_content "Signed in as"
    expect(page).to_not have_content "Sign In"
  end
end
