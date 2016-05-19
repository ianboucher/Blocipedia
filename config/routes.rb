Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/about'

  root 'welcome#index'

end
