Rails.application.routes.draw do
  root'static_pages#home'
  get '/about', to: "static_pages#about"
  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"
  get '/dashboard/:id', to: "users#dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions, only:[:create]
  resources :relationships, only:[:create, :destroy]
end
