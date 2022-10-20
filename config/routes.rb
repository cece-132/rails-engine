Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'search#find_item'
      resources :items do
        get '/merchant', to: 'item_merchants#show'
      end
      resources :merchants, only: [:index, :show] do
        get "/items", to: 'merchant_items#index'
      end
    end
  end
end
