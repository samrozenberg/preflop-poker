Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  resources :games do
    resources :hands, only: [:create, :update] do
      resources :flop_cards, only: :create
      resources :turn_cards, only: :create
      resources :river_cards, only: :create
      resources :bets, only: :create
      resources :user_hands, only: :update
    end
    resources :reservations, only: [:create, :destroy, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard"
  delete 'games/:id', to: 'games#destroy', as: :destroy
end
