Rails.application.routes.draw do
  root "static_pages#home"
  get '/help', to: "static_pages#help"
  get '/search', to: 'searchs#search'

end
