Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games do
    resources :hands do
      resources :flop_cards, only: :create
      resources :turn_cards, only: :create
      resources :river_cards, only: :create
      resources :bets, only: :create
    end
    resources :reservations, only: [:create, :destroy, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard"
  delete 'games/:id', to: 'games#destroy', as: :destroy
end
