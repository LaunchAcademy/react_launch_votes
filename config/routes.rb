Rails.application.routes.draw do
  get "/auth/failure", to: "sessions#failure"
  get "auth/:provider/callback", to: "sessions#create"
  delete "sign-out", to: "sessions#destroy"

  root "pages#index"

  resources :auth, only: :show
  resources :users, only: :show
end

