require "rails_helper"

RSpec.describe Api::V1::TeamsController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "GET #show" do
    let(:team) { create :team, name: "DGHDA Squad" }
    let(:dirk) { create :user, name: "Dirk Gently" }
    let(:todd) { create :user, name: "Todd Brotzman" }
    let(:amanda) { create :user, name: "Amanda Brotzman" }
    let(:farah) { create :user, name: "Farah Black" }
    let!(:nomination1) { create :nomination, body: "Best Jacket", nominator: todd, nominee: dirk, team: team }
    let!(:nomination2) { create :nomination, body: "Best Hair", nominator: amanda, nominee: farah, team: team }

    it "returns a serialized team, with nested serialized nominations and users" do
      session[:user_id] = farah.id
      get :show, params: { id: team.id }

      expect(json_parsed_response.keys).to eq ["id", "name", "nominations", "users"]
      expect(json_parsed_response["users"].map{|user| user["name"]}).to eq ["Amanda Brotzman", "Dirk Gently", "Farah Black", "Todd Brotzman"]
      expect(json_parsed_response["nominations"].map{|nomination| nomination["body"]}).to eq ["Best Jacket", "Best Hair"]
    end
  end
end
