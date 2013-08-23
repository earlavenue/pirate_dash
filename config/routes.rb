PirateMetricsDashboard::Application.routes.draw do

  root to: 'people#index'

  resources :organizations
  resources :clients
  resources :people,:only => [:index, :show]

  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create', as: 'sessions'
  delete '/sessions' => 'sessions#destroy', as: 'session'

  get '/memberships/handshake' => 'memberships#handshake', as: 'handshake'
  post '/memberships' => 'memberships#create'

end
