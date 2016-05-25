Rails.application.routes.draw do

  get 'invoices/create'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :update]

  resources :wikis

  resources :memberships, only: [:new, :create, :destroy]

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  get 'welcome/about'

  root 'welcome#index'

  namespace :stripe do
    resources :subscription_events, only: :create
  end

end
