Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :show]
      resources :words, only: [:index, :show]
      get '/long', to: 'words#long'
      get '/hard', to: 'words#hard'
    end
  end

  get '/games/top', to: 'games#top'

  resources :users, only: [:show, :create, :update]
  resources :sessions, only: [:create]
  resources :games, only: [:index, :create, :update]

end
