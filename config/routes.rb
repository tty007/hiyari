Rails.application.routes.draw do
  
  root 'pages#index'
  get 'about' => 'pages#about'
  get 'users/index'
  get 'users/show'
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
