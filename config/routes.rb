# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboards#index'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users/:id/discover', to: 'users#discover'
  resources :users, only: %i[index show create] do
    resources :movies, controller: 'user_movies', only: %i[index show] do
      resources :view_parties, controller: 'view_parties', only: %i[new create]
    end
  end
end