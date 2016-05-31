Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :update]

  resources :memberships, only: [:new, :create, :destroy]

  resources :wikis do
    resources :collaborations, only: [:index, :create, :destroy]
  end

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  namespace :stripe do
    resources :subscription_events, only: :create
  end

  get 'welcome/about'

  root 'welcome#index'
end
