Rails.application.routes.draw do

  get '/signup', to: 'users#new' #define route for signup page
  post '/signup', to: 'users#create'#define route for signup submission

  resources :users #index, show, new, edit, crete, update, destroy
end
