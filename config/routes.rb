PirateMetricsDashboard::Application.routes.draw do
  resources :people do
    collection { post :import }
  end


  root to: 'Sessions#new'

  resources :users

  get '/dashboard' => 'Pages#dashboard', as: 'dashboard'
  get '/refresh' => 'Pages#refresh', as: 'refresh'


  get '/sessions/new' => 'Sessions#new', as: 'new_session'
  post '/sessions' => 'Sessions#create', as: 'sessions'
  delete '/sessions' => 'Sessions#destroy', as: 'session'

  end
