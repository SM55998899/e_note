Rails.application.routes.draw do
  get 'users/new'
  root "static_pages#home"
  get '/help', to: "static_pages#help"
  get '/search', to: 'searchs#search'
  get '/signup', to: 'users#new'

end
