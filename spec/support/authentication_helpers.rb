module AuthenticationHelpers
  def link_launch_pass(uid = "9999", email = "makewayforlaf@silasuniversity.edu", teams = [])
    serialized_teams = teams.map { |t| { "id" => t.launch_pass_id, "name" => t.name } }
    OmniAuth.config.mock_auth[:launch_pass] = OmniAuth::AuthHash.new({
      provider: "launch_pass",
      uid: uid,
      info: {
        email: email,
        teams: serialized_teams
      }
    })
    visit auth_path(:launch_pass)
  end

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

  def sign_in_failure
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: nil,
      info: {
        nickname: nil,
        image: nil,
        name: nil
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
