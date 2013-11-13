PirateMetricsDashboard::Application.routes.draw do

  get '/people/export_to_csv' => 'people#export_to_csv', as: 'export'

  get '/activity_data' => 'uploads#api', as: 'api'

  root to: 'people#index'

  resources :organizations

  resources :clients
  get '/clients/:id/edit_profile' => 'clients#edit_profile', as: 'edit_profile'
  get '/clients/:id/edit_password' => 'clients#edit_password', as: 'edit_password'
  patch 'clients/:id/edit_profile' => 'clients#update_profile', as: 'update_profile'
  patch 'clients/:id/edit_password' => 'clients#update_password', as: 'update_password'

  resources :people,:only => [:index, :show]


  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create', as: 'sessions'
  delete '/sessions' => 'sessions#destroy', as: 'session'

  get '/pirates/activations' => 'pirates#activations', as: 'activations'
  get '/pirates/devices' => 'pirates#devices', as: 'devices'
  get '/pirates/retention' => 'pirates#retention', as: 'retention'
  get '/pirates/users_lost' => 'pirates#users_lost', as: 'users_lost'
end

