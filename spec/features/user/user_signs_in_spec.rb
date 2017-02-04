require "rails_helper"

RSpec.feature "user signs in" do
  before(:each) do
    sign_out
  end

  let!(:user) { create :user }

  it "starts a signed-in session" do
    sign_in(user)

    expect(page).to have_content "Sign Out"
    expect(page).to have_content "Signed in as"
    expect(page).to_not have_content "Sign In"
  end

  it "does not create a new user" do
    expect{sign_in(user)}.to_not change{User.count}
  end
end