Rails.application.routes.draw do
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
  resources :microposts,          only: [:create, :destroy]
  resources :cards,               only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  get '/microposts', to: 'static_pages#diary'
  get "regist", to: "static_pages#regist"
  get '/cards', to: 'static_pages#regist'
end
