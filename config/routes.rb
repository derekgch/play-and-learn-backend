Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :show]
    end
  end

  resources :users, only: [:index, :show, :create, :update]
  resources :sessions, only: [:create]

end