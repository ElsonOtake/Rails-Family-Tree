# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'api/v1/users#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :pairs, only: %i[index show]
      resources :branches, only: %i[index show]
    end
  end
end
