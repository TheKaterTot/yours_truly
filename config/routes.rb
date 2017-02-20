Rails.application.routes.draw do

  root "home#index"

  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"
  post '/login', to: "sessions#create"
  get '/signup', to: "users#new", as: :sign_up

  resources :users, only: [:create, :show, :destroy]
  resources :letters, only: [:new, :create, :show]

  get '/templates/:id/random', to: "random_templates#show"
end
