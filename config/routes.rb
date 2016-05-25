Rails.application.routes.draw do

  get 'invoices/create'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :update]

  resources :wikis

  resources :subscriptions, only: [:new, :create]

  resources :invoices, only: [:new, :create]

  resources :refunds, only: [:new, :create]

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  get 'welcome/about'

  root 'welcome#index'

  namespace :stripe do
    resources :subscriptions, only: :create
    resources :invoices, only: :create
  end

end
