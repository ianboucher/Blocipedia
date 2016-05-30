Rails.application.routes.draw do

  get 'collaborations/destroy'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :update]

  resources :memberships, only: [:new, :create, :destroy]

  resources :wikis

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  namespace :stripe do
    resources :subscription_events, only: :create
  end

  get 'welcome/about'

  root 'welcome#index'
end
