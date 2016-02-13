Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
  resources :notes, only: [:new, :create, :show]
  root 'static#home'
  get '/pages/about', to: 'static#about'
end