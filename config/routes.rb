Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :retros
  get '/active', to: 'active#index'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
