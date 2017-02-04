require "rails_helper"

RSpec.feature "user signs in" do
  let(:user) { create :user }

  it "ends a signed-in session" do
    sign_in(user)
    click_on "Sign Out"

    expect(page).to_not have_content "Sign Out"
    expect(page).to have_content "Signed out"
    expect(page).to have_content "Sign In"
  end
end
