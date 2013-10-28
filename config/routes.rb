PirateMetricsDashboard::Application.routes.draw do

  get '/people/export_to_csv' => 'people#export_to_csv', as: 'export'

  root to: 'people#index'

  resources :organizations
  resources :clients
  resources :people,:only => [:index, :show]


  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create', as: 'sessions'
  delete '/sessions' => 'sessions#destroy', as: 'session'

  get '/pirates/activations' => 'pirates#activations', as: 'activations'
  get '/pirates/devices' => 'pirates#devices', as: 'devices'
  get '/pirates/retention' => 'pirates#retention', as: 'retention'
  get '/pirates/users_lost' => 'pirates#users_lost', as: 'users_lost'
end
