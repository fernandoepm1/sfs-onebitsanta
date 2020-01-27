require 'sidekiq/web'

Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users, :controllers => { registrations: 'registrations' }

  # Not safe to define an open route like this
  mount Sidekiq::Web => '/sidekiq'
end
