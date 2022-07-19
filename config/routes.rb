# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'register#index'
  get '/register', to: 'users#new'
  post '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'

  get '/users/:id/discover', to: 'users#discover'
  resources :users, only: %i[index show create] do
    resources :movies, controller: 'user_movies', only: %i[index show] do
      resources :view_parties, controller: 'view_parties', only: %i[new create]
    end
  end
end