# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/profile(/:id)', to: "users#show"
  get 'tuits/index'
  resources :tuits, only: [:show]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
