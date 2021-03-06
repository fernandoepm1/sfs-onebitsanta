require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Not safe to define an open route like this
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'

  resources :parties, except: [:new, :edit] do
    post 'match', on: :member
  end

  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :update, :destroy]
end
