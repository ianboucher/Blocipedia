Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :wikis

  get 'welcome/about'

  root 'welcome#index'

end
