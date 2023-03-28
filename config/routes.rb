Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root "static_pages#home"
  get '/help', to: "static_pages#help"
  get '/search', to: 'searchs#search'
  get '/signup', to: 'users#new'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get "/diary", to: "static_pages#diary"
  resources :users
  resources :microposts,          only: %i(create destroy show)
  resources :cards,               only: %i(create destroy index) do
    resources :likes, only: [:create, :destroy]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  get '/microposts', to: 'static_pages#diary'
  get "regist", to: "static_pages#regist"
  get '/cards', to: 'static_pages#regist'
  get '/todolist', to: "todo#list"
  resources :list, only: %i(new create edit update destroy) do
    resources :tip, except: %i(index)
  end
  resources :contacts, only: [:new, :create]
end
