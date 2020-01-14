Rails.application.routes.draw do
  root 'rails/welcome#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
