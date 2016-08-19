Rails.application.routes.draw do

  root 'notes#index'
  
  devise_for :users
  resources :users

end