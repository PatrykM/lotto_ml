Rails.application.routes.draw do
  resources :lotto_games, only: %i[index show new create]
  resources :multi_games, only: %i[index show new create]
  resources :neural_networks, only: %i[index show new create]

  get 'neural_networks/evaluate', to: 'neural_networks#evaluate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
