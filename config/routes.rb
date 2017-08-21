Rails.application.routes.draw do
  resources :lotto_games, only: [:index, :show, :new, :create]
  resources :multi_games, only: [:index, :show, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
