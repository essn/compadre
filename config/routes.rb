Compadre::Engine.routes.draw do
  resources :friendships, only: [:create, :update, :index, :show, :delete]
  resources :friend_requests, only: [:create, :update, :index, :show, :delete]
end
