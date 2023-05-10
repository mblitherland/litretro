Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  get 'retro', to: 'retro#index'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
