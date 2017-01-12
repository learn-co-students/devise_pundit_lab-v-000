Rails.application.routes.draw do
  devise_for :users
  resources :users

  # You can have the root of your site routed with "root"
  root 'users#index'


end
