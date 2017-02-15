require "rails_helper"

RSpec.describe Api::V1::NominationsController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "POST #create" do
    let(:team) { create :team }
    let(:nominator) { create :user }
    let(:nominee) { create :user }
    let!(:nominator_membership) { create :membership, user: nominator, team: team }
    let!(:nominee_membership) { create :membership, user: nominee, team: team }

    let(:correct_nomination_params) { { body: "Most Helpful", nominee_id: nominee.id } }
    let(:incorrect_nomination_params) { { nominee_id: nominee.id } }

    it "successfully nominates a user" do
      session[:user_id] = nominator.id
      expect { post :create, team_id: team.id, nomination: correct_nomination_params }.to change{ Nomination.count }.by 1
    end

    it "returns an error when the payload is incorrect" do
      session[:user_id] = nominator.id
      post :create, team_id: team.id, nomination: incorrect_nomination_params

      expect(response.status).to eq 422
      expect(json_parsed_response.keys).to eq ["errors"]
      expect(json_parsed_response["errors"]).to eq ["Body can't be blank"]
    end
  end
end
