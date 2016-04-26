Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  resources :notes
  resources :users, only: [:index, :show]
  get 'pages/about' => 'pages#about'
end
