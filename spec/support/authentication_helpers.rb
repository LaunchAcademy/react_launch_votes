module AuthenticationHelpers
  def sign_in(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: user.github_id,
      info: {
        nickname: user.handle,
        image: user.image_url,
        name: user.name
      }
    })
    visit auth_path(:github)
  end

  def sign_up_user(uid = "4747")
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: uid,
      info: {
        nickname: "LaFilphormes",
        image: "http://tumblr.com",
        name: "LaFontaine"
      }
    })
    visit auth_path(:github)
  end

  def sign_out
    page.driver.submit :delete, sign_out_path, {}
  end
end
