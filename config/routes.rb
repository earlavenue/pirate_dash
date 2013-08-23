PirateMetricsDashboard::Application.routes.draw do

  root to: 'people#index'

  resources :organizations
  resources :clients
  resources :people,:only => [:index, :show]

  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create', as: 'sessions'
  delete '/sessions' => 'sessions#destroy', as: 'session'

  get '/memberships/handshake' => 'memberships#handshake', as: 'handshake'
  get '/memberships/handshake_retake' => 'memberships#handshake_retake', as: 'handshake_retake'
  post '/memberships' => 'memberships#create'
  put '/memberships/:id' => 'memberships#update', as: 'membership'

end
