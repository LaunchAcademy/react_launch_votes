require "rails_helper"

RSpec.describe Api::V1::VotesController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "#POST create" do
    let(:nomination) { create :nomination }
    let(:user) { create :user }
    let(:admin) { create :admin_user }
    let(:non_team_user) { create :user }
    let!(:membership) { create :membership, team: nomination.team, user: user }

    describe "it returns the vote's nomination as JSON" do
      it "as a team member user" do
        session[:user_id] = user.id
        post :create, params: { vote: { nomination_id: nomination.id } }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      end

      it "as an admin user" do
        session[:user_id] = admin.id
        post :create, params: { vote: { nomination_id: nomination.id } }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      end
    end

    it "successfully votes for a nomination" do
      session[:user_id] = user.id
      expect { post :create, params: { vote: { nomination_id: nomination.id } } }.to change{ Vote.count }.by 1
    end

    it "it returns an error if the user is not authorized to vote" do
      session[:user_id] = non_team_user.id
      post :create, params: { vote: { nomination_id: nomination.id } }

      expect(response.status).to eq 403
      expect(json_parsed_response.keys).to eq ["errors"]
    end
  end

  describe "DELETE #destroy" do
    let(:vote) { create :vote }

    it "it returns the deleted vote's nomination as JSON" do
      session[:user_id] = vote.user.id
      delete :destroy, params: { id: vote.id }

      expect(response.status).to eq 200
      expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      expect(json_parsed_response["id"]).to eq vote.nomination.id
    end

    it "successfully deletes a vote" do
      expect { delete :destroy, params: {id: vote.id} }.to change{ Vote.count }.by 1
    end
  end
end
