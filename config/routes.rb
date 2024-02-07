Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :retros do
    resources :columns
    resources :icebreakers
    resources :participants
  end

  # Alphabetize by URL first, followed by method. Well, approximately.
  get '/about', to: 'home#about'
  get '/active', to: 'active#index'
  get '/cards/:id/vote/:participant_id', to: 'cards#vote'
  post '/cards', to: 'cards#create'
  post '/comments', to: 'comments#create'
  delete '/comments/:id', to: 'comments#delete'
  get '/complete/:id', to: 'complete#index'
  get '/discussion/:id', to: 'discussion#index'
  get '/grouping/:id', to:'grouping#index'
  get '/guest/:id', to: 'guest#index'
  get '/guest/:id/join_registered', to: 'guest#join_registered'
  post '/guest/:id/join_guest', to: 'guest#join_guest'
  get '/participants/:id/prior/:prior_id', to: 'participants#add_prior'
  get '/pointing/:id', to: 'pointing#index'
  get '/retros/guest_offset/:offset', to: 'retros#guest_offset'
  get '/retros/retro_offset/:offset', to: 'retros#retro_offset'
  get '/retros/:id/add_guest_link', to: 'retros#add_guest_link'
  get '/retros/:id/icebreaker', to: 'retros#icebreaker_tab'
  get '/retros/:id/remove_guest_link', to: 'retros#remove_guest_link'
  get '/retros/:id/theme', to: 'retros#theme_tab'
  get '/started/:id', to: 'started#index'
  get '/started/:id/delete_card/:card_id', to: 'started#delete_card'
  get '/started/:id/edit_card/:card_id', to: 'started#edit_card'
  post '/started/:id', to: 'started#create'
  get '/welcome/:id', to: 'welcome#index'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
end
