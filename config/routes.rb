Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  resources :comments, only: [:create]
  resources :posts, only: [:index, :show, :create]
end
