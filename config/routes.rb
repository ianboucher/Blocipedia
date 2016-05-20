Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :wikis

  resources :charges, only: [:new, :create]

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  get 'welcome/about'

  root 'welcome#index'

end
