Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'account/Activations'

  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get '/signup', to: 'users#new' #define route for signup page
  post '/signup', to: 'users#create'#define route for signup submission
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users #index, show, new, edit, crete, update, destroy
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :task_entries
  resources :tasks
  resources :projects
  resources :customers
end
