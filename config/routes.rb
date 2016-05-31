Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:index, :show, :update] do
    collection do # don't know why I need this
      get :autocomplete
    end
  end

  resources :wikis do
    resources :collaborations, only: [:index, :create, :destroy]
    collection do # don't know why I need this
      get :autocomplete
    end
  end

  resources :memberships, only: [:new, :create, :destroy]

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  namespace :stripe do
    resources :subscription_events, only: :create
  end

  get 'welcome/about'

  root 'welcome#index'
end
