Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  root to: "sessions#new"
  resources :sessions
  resources :users
  resources :conversations
  mount ActionCable.server => '/cable'
end
