Rails.application.routes.draw do
  get 'pages/about'
  get 'static/about'

  devise_for :users
  resources :users

  root 'notes#index'
  get '/about', to: 'pages#about'
end
