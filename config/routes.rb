Rails.application.routes.draw do
  root "pages#index"

  get "/auth/:provider/callback", to: "authentication_flows#create"
  delete "sign-out", to: "sessions#destroy"
  get "team-selector", to: "team_selector#index"

  namespace :admin do
    resources :teams, only: [:index, :show, :update]
  end

  namespace :api do
    namespace :v1 do
      resources :nominations, only: :destroy
      resources :teams, only: :show do
        resources :nominations, only: [:create, :index, :show, :update]
      end
      resources :users, only: [] do
        collection do
          resources :current, only: :index
        end
      end
      resources :votes, only: [:create, :destroy]
    end
  end

  # for omniauth link helper 
  # resources :auth, only: :show

  resources :sessions, only: :new
  resources :teams, only: [] do
    resources :awards, only: :index
    resources :nominations, only: [:edit, :index]
  end
  resources :user_teams, only: :edit
  resources :users, only: [:show, :update]
end

