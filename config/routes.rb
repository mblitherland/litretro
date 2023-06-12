Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :retros do
    resources :columns
    resources :icebreakers
    resources :participants
  end

  get '/active', to: 'active#index'

  get '/welcome/:id', to: 'welcome#index'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
