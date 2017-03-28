Rails.application.routes.draw do
  root to: 'posts#index'
  resources :comments
  resources :posts
  resources :authors

  # You only need this for GraphQl
  resource :graphql, only: [:create], controller: 'graphql'
end
