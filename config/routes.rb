Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  get "signin", to: "sessions#new", as: "signin"

  root "pages#index"

  resources :auth, only: :show
  resources :sessions, only: [:destroy, :new]
end
