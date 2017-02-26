require "rails_helper"

RSpec.describe Api::V1::CurrentController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "GET #index" do
    let(:user) { create :user }

    it "returns a serialized user" do
      session[:user_id] = user.id
      get :index, params: { user: {} }

      expect(json_parsed_response.keys).to eq ["admin?", "id", "name", "teams"]
      expect(json_parsed_response["name"]).to eq user.name
    end

    it "returns errors if the user is not signed in" do
      get :index, params: { user: {} }

      expect(json_parsed_response.keys).to eq ["errors"]
    end
  end
end
