Rails.application.routes.draw do
  devise_for :users
  root 'static#home'
  get 'about', to: 'pages#about'
  resources :users
end
