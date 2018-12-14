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


  resources :customers do
    resources :projects, only: [:index, :new, :create]
  end

  resources :projects, only: [:show, :edit, :update, :destroy] do
    resources :tasks, only: [:index, :new, :create]
  end

  resources :tasks, only: [:show, :edit, :update, :destroy] do
    resources :task_entries, only: [:index, :new, :create]
  end

  resources :task_entries, only: [:show, :edit, :update, :destroy]


  # All other routes
  match "*path", to: "application#index", via: :all

end
