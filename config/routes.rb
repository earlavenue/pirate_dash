PirateMetricsDashboard::Application.routes.draw do
  resources :people do
    collection { post :import }
  end
  get '/sync' => 'People#sync', as: 'sync'
  get '/operations' => 'People#operations', as: 'operations'

  root to: 'Pages#dashboard'

  resources :users

  get '/dashboard' => 'Pages#dashboard', as: 'dashboard'
  get '/refresh' => 'Pages#refresh', as: 'refresh'


  get '/sessions/new' => 'Sessions#new', as: 'new_session'
  post '/sessions' => 'Sessions#create', as: 'sessions'
  delete '/sessions' => 'Sessions#destroy', as: 'session'

  end
