Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :update]

  resources :wikis

  resources :subscriptions, only: [:new, :create, :destroy]

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  get 'welcome/about'

  root 'welcome#index'

end
