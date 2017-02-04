Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  delete "sign-out", to: "sessions#destroy"

  root "pages#index"

  resources :auth, only: :show
end
