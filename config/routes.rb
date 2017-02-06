Rails.application.routes.draw do
  get "auth/:provider/callback", to: "authentication_flows#create"
  delete "sign-out", to: "sessions#destroy"

  root "pages#index"

  resources :auth, only: :show
  resources :sessions, only: :new
  resources :user_teams, only: :edit
  resources :users, only: :show
end

