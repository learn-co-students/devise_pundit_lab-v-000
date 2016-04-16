Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'notes#index'
  resources :users
end
