require "rails_helper"

RSpec.describe Api::V1::TeamsController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }
  before(:all) do
    Team.find_or_create_by(name: "Admins")
  end

  describe "GET #show" do
    let(:team) { create :team, name: "DGHDA Squad" }
    let(:dirk) { create :user, name: "Dirk Gently" }
    let(:todd) { create :user, name: "Todd Brotzman" }
    let(:amanda) { create :user, name: "Amanda Brotzman" }
    let(:farah) { create :user, name: "Farah Black" }
    let!(:nomination1) { create :nomination, body: "Best Jacket", nominator: todd, nominee: dirk, team: team }
    let!(:nomination2) { create :nomination, body: "Best Hair", nominator: amanda, nominee: farah, team: team }
    describe "as a signed in team member" do
      it "returns a serialized team, with nested serialized nominations and users" do
        session[:user_id] = farah.id
        get :show, params: { id: team.id }

        expect(json_parsed_response.keys).to eq ["id", "name", "nomination_placeholder", "nominations", "users"]
        expect(json_parsed_response["users"].map{|user| user["name"]}).to eq ["Amanda Brotzman", "Dirk Gently", "Farah Black", "Todd Brotzman"]
        expect(json_parsed_response["nominations"].map{|nomination| nomination["body"]}).to eq ["Best Jacket", "Best Hair"]
      end
    end
    describe "as a signed in admin" do
      let(:admin) { create :admin_user, name: "Bart Curlish" }
      it "returns a serialized team" do
        session[:user_id] = admin.id
        get :show, params: { id: team.id }

        expect(json_parsed_response.keys).to eq ["id", "name", "nomination_placeholder", "nominations", "users"]
        expect(json_parsed_response["users"].map{|user| user["name"]}).to eq ["Amanda Brotzman", "Dirk Gently", "Farah Black", "Todd Brotzman", "Bart Curlish"]
        expect(json_parsed_response["nominations"].map{|nomination| nomination["body"]}).to eq ["Best Jacket", "Best Hair"]
      end
    end
    describe "as an unauthenticated guest" do
      it "returns errors" do
        get :show, params: { id: team.id }

        expect(json_parsed_response.keys).to eq ["errors"]
        expect(json_parsed_response["errors"]).to eq "not authorized"
      end
    end
  end
end
