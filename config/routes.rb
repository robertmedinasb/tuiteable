# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/profile/:id', to: 'users#show',as: 'user'
  get 'tuits/index'
  resources :tuits, only: [:show]
  namespace :api do
    resources :comments, only: [:index, :create, :destroy]
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/users/profile/:id/liked', to: 'users#liked'
  get '/like/:id', to: 'tuits#like'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
