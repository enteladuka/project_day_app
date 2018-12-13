Rails.application.routes.draw do


  root 'sessions#new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'account/Activations'

  get 'home', to: 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :task_entries
  resources :tasks
  resources :customers do
    resources :projects
  end

  # remember to defind resources like this  resources :photos, :books, :videos


  # All other routes
 match "*path", to: "application#index", via: :all
end
