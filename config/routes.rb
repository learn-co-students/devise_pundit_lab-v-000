Rails.application.routes.draw do

  devise_for :users
  
  resources :users, only: [:index, :show]
  
  root 'notes#index'
  
  get 'pages/about', to: 'static#about', as: 'about'
end
