require 'sidekiq/web'

Rails.application.routes.draw do
  get 'gatherings/index'
  get 'gatherings/create'
  get 'gatherings/show'
  get 'gatherings/update'
  get 'gatherings/destroy'
  get 'gatherings/raffle'
  get 'pages/home'
  devise_for :users, :controllers => { registrations: 'registrations' }

  # Not safe to define an open route like this
  mount Sidekiq::Web => '/sidekiq'
end
