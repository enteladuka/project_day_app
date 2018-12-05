Rails.application.routes.draw do
  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get '/signup', to: 'users#new' #define route for signup page
  post '/signup', to: 'users#create'#define route for signup submission
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users #index, show, new, edit, crete, update, destroy
end
