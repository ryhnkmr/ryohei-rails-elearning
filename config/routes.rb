Rails.application.routes.draw do

  root'static_pages#home'
  get '/about', to: "static_pages#about"
  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"
  get '/dashboard', to: "users#dashboard"
  patch '/admin/users/:id', to: "admin/users#update"
  get '/categories', to: "categories#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions, only:[:create]
  resources :relationships, only:[:create,:destroy]
  
  resources :lessons , only:[:show, :create] do
    resources :answers, only:[:new,:create]
    # post '/answers', to: "answers#create"
  end

  namespace :admin do
    resources :users, only:[:index, :destroy]
    resources :categories do
      resources :words do
        resources :choices 
      end
    end
  end

end
