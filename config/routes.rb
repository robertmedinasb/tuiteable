# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/profile/:id', to: 'users#show', as: 'user'
  get 'tuits/index'
  resources :tuits, only: %i[show create]
  namespace :api, defaults: { format: 'json' } do
    devise_scope :user do
      post 'sign_up', to: 'registrations#create'
      post 'sign_in', to: 'sessions#create'
      post 'sign_out', to: 'sessions#destroy'
    end
    resources :comments, only: %i[index create destroy]
    resources :tuits
    # Nested routes
    resources :tuits do
      resources :comments, only: %i[index create destroy]
      resources :likes, only: %i[index create destroy show]
    end

    resources :users do
      resources :tuits
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/users/profile/:id/liked', to: 'users#liked'
  get '/like/:id', to: 'tuits#like'
  post '/comment/:id', to: 'tuits#comment' # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
