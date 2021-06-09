Rails.application.routes.draw do

  resources :pages
  get '/pages/about', to: 'pages#show'
  devise_for :users

  resources :users

  root to: 'users#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
