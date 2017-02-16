require "rails_helper"

RSpec.describe Api::V1::CurrentController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "GET #show" do
    let(:user) { create :user }

    it "returns a serialized user" do
      session[:user_id] = user.id
      get :index, params: { user: {} }

      expect(json_parsed_response.keys).to eq ["id", "handle", "image_url", "name"]
      expect(json_parsed_response["name"]).to eq user.name
    end
  end
end
