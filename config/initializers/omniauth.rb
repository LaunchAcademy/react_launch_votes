launch_pass_sites = {
  development: "http://localhost:3001/",
  staging: "https://launch-pass-staging.herokuapp.com",
  production: "https://launchpass.launchacademy.com"
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
  provider :launch_pass, ENV["LAUNCH_PASS_KEY"], ENV["LAUNCH_PASS_SECRET"],
    client_options: {
      site: launch_pass_sites[Rails.env.to_sym]
    }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
