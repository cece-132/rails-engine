Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/merchants/:id/items', to: 'merchants/items#index'
      get '/merchants/find', to: 'merchants/search#find'
      get '/merchants/find_all', to: 'merchants/search#find_all'

      get '/items/:id/merchant', to: 'items/merchant#show'
      get '/items/find', to: 'items/search#find'
      get '/items/find_all', to: 'items/search#find_all'

      resources :merchants, only: [:index, :show]
      resources :items

    end
  end

end
