PirateMetricsDashboard::Application.routes.draw do
  resources :people do
    collection { post :import }
  end

  get '/operations' => 'People#operations', as: 'operations'

  root to: 'People#index'

  resources :users

  post '/import_uploads' => 'People#import_uploads', as: 'import_uploads'



  get '/sessions/new' => 'Sessions#new', as: 'new_session'
  post '/sessions' => 'Sessions#create', as: 'sessions'
  delete '/sessions' => 'Sessions#destroy', as: 'session'

  end
