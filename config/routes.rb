Rails.application.routes.draw do
  resources :users
 root "homes#index"
end
