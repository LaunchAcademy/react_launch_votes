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

    it "it returns the nomination as JSON" do
      session[:user_id] = nominator.id
      post :create, params: { team_id: team.id, nomination: correct_nomination_params }

      expect(response.status).to eq 200
      expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
    end

    it "successfully nominates a user" do
      session[:user_id] = nominator.id
      expect { post :create, params: { team_id: team.id, nomination: correct_nomination_params } }.to change{ Nomination.count }.by 1
    end

    it "returns an error when the payload is incorrect" do
      session[:user_id] = nominator.id
      post :create, params: { team_id: team.id, nomination: incorrect_nomination_params }

      expect(response.status).to eq 422
      expect(json_parsed_response.keys).to eq ["errors"]
      expect(json_parsed_response["errors"]).to eq ["Body can't be blank"]
    end
  end

  describe "DELETE #destroy" do
    let(:nomination) { create :nomination }

    it "it returns the deleted nomination as JSON" do
      session[:user_id] = nomination.nominator.id
      delete :destroy, params: { id: nomination.id }

      expect(response.status).to eq 200
      expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      expect(json_parsed_response["id"]).to eq nomination.id
    end

    it "successfully deletes a nomination" do
      expect { delete :destroy, params: {id: nomination.id} }.to change{ Nomination.count }.by 1
    end
  end

  describe "GET #show" do
    let(:nomination) { create :nomination }
    let(:user) { create :user }
    let(:admin) { create :admin_user }

    describe "it returns the nomination as JSON" do
      it "as the nominator user" do
        session[:user_id] = nomination.nominator.id
        get :show, params: { team_id: nomination.team_id, id: nomination.id }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      end

      it "as an admin user" do
        session[:user_id] = admin.id
        get :show, params: { team_id: nomination.team_id, id: nomination.id }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "body", "nominator_id", "nominee_id", "nominee", "voter_ids"]
      end
    end

    it "returns an error if the user is not signed in" do
      get :show, params: { team_id: nomination.team_id, id: nomination.id }

      expect(response.status).to eq 401
      expect(json_parsed_response.keys).to eq ["errors"]
    end

    it "returns an error if the user is a non-admin nominator" do
      session[:user_id] = user.id
      get :show, params: { team_id: nomination.team_id, id: nomination.id }

      expect(response.status).to eq 403
      expect(json_parsed_response.keys).to eq ["errors"]
    end
  end

  describe "PATCH #update" do
    let(:nomination) { create :nomination }
    let(:user) { create :user }
    let(:admin) { create :admin_user }

    describe "it returns the nomination team as JSON (with nested updated nomination)" do
      it "as the nominator user" do
        session[:user_id] = nomination.nominator.id
        patch :update, params: { id: nomination.id, team_id: nomination.team.id, nomination: { body: "Least Something" } }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "name", "nominations", "users"]
        expect(json_parsed_response["id"]).to eq nomination.team.id
        expect(json_parsed_response["nominations"].map{ |n| n["id"] }).to include(nomination.id)
      end

      it "as an admin user" do
        session[:user_id] = admin.id
        patch :update, params: { id: nomination.id, team_id: nomination.team.id, nomination: { body: "Least Something" } }

        expect(response.status).to eq 200
        expect(json_parsed_response.keys).to eq ["id", "name", "nominations", "users"]
        expect(json_parsed_response["id"]).to eq nomination.team.id
        expect(json_parsed_response["nominations"].map{ |n| n["id"] }).to include(nomination.id)
      end
    end

    it "returns an error with unacceptable params" do
      session[:user_id] = nomination.nominator.id
      patch :update, params: { id: nomination.id, team_id: nomination.team.id, nomination: { body: "" } }

      expect(response.status).to eq 422
      expect(json_parsed_response.keys).to eq ["errors"]
    end
  end
end
