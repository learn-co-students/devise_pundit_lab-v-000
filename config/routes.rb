Rails.application.routes.draw do


  devise_for :users
  resources :users, only: [:show, :index, :edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'

  resources :notes  
end
