PirateMetricsDashboard::Application.routes.draw do

  root to: 'People#index'

  resources :organizations
  resources :clients
  resources :people

  get '/sessions/new' => 'Sessions#new', as: 'new_session'
  post '/sessions' => 'Sessions#create', as: 'sessions'
  delete '/sessions' => 'Sessions#destroy', as: 'session'

  get '/memberships/handshake' => 'Memberships#handshake', as: 'handshake'
  post '/memberships' => 'Memberships#create'
  put '/memberships/:id' => 'Memberships#update', as: 'membership'

end
