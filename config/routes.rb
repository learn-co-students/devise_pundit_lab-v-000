Rails.application.routes.draw do
  devise_for :users
	resources :users
	
  root 'notes#index'
end
