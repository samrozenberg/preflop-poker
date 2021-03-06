Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'pages#home'
  resources :games do
    resources :hands, only: [:create, :update] do
      resources :flop_cards, only: :create
      resources :turn_cards, only: :create
      resources :river_cards, only: :create
      resources :bets, only: :create
      resources :user_hands, only: :update
      resources :user_cards, only: :destroy
    end
    resources :reservations, only: [:create, :destroy, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard"
  get "/all_hands", to: "pages#all_hands"
  delete 'games/:id', to: 'games#destroy', as: :destroy
end
