Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :places, only: [:index, :show]
  resources :contacts, only: [:new, :create]
  namespace :my do
    resources :places, only: [:index, :new, :create, :edit, :update]
  end

  mount Attachinary::Engine => "/attachinary"
end
