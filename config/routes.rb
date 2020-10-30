Rails.application.routes.draw do
  resources :transactions
  resources :groups
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  root "transactions#index"

  get '/external', to: 'homes#external'
  get '/friend_transaction', to: 'homes#friend_transaction'
end
