# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/profile/:id', to: 'profiles#show', as: 'profile'
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
  resources :tuits
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  put 'profiles/edit', to: 'profiles#edit'
  get '/profiles/profile/:id/liked', to: 'profiles#liked'
  get '/follow/:id', to: 'profiles#follow'
  get '/unfollow/:id', to: 'profiles#unfollow'
  get '/like/:id', to: 'tuits#like'
  delete 'comment/:id', to: 'tuits#delete_comment'
  post '/comment/:id', to: 'tuits#comment' # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/home', to: 'home#home'
  root to: 'home#index'
end
