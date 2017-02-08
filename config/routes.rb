Rails.application.routes.draw do
  root "pages#index"

  get "auth/:provider/callback", to: "authentication_flows#create"
  delete "sign-out", to: "sessions#destroy"

  namespace :api do
    namespace :v1 do
      resources :teams, only: [] do
        resources :nominations, only: [:create, :index]
      end
    end
  end

  resources :auth, only: :show
  resources :sessions, only: :new
  resources :user_teams, only: :edit
  resources :users, only: :show
end

