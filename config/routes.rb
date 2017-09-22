Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :places, only: [:show]
  namespace :my do
    resources :places, only: [:index, :new, :create]
  end
end
