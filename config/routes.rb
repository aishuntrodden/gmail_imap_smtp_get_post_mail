App::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
 get 'allusers', to: 'users#index', as: 'allusers'
get 'user_path',to: 'user#show' , as: 'user_path'
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :users, only: [:update, :index, :show]

  root to: "home#show"
end