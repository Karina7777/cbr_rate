Rails.application.routes.draw do

  mount API::Base => '/'

  root to: 'main#index'
  namespace :admin do
    root to: 'main#index'
    resources :main, only: [:index, :create]
  end
end
