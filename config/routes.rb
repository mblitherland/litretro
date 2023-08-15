Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :retros do
    resources :columns
    resources :icebreakers
    resources :participants
  end

  # Alphabetize by URL with POST for a given controller after GET
  get '/active', to: 'active#index'
  get '/cards/:id/vote/:participant_id', to: 'cards#vote'
  post '/cards', to: 'cards#create'
  post '/comments', to: 'comments#create'
  get '/complete/:id', to: 'complete#index'
  get '/discussion/:id', to: 'discussion#index'
  get '/guest/:id', to: 'guest#index'
  get '/pointing/:id', to: 'pointing#index'
  get '/retros/:id/add_guest_link', to: 'retros#add_guest_link'
  get '/retros/:id/remove_guest_link', to: 'retros#remove_guest_link'
  get '/started/:id', to: 'started#index'
  post '/started/:id', to: 'started#create'
  get '/welcome/:id', to: 'welcome#index'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
