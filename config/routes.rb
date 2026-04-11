Rails.application.routes.draw do
  namespace :api do
    # Health check for the frontend connection status
    get 'readiness', to: 'readiness#index'
    
    namespace :v1 do
      resources :inventories, only: [:index, :show]
      resources :kits, only: [:index]
      resources :orders, only: [:index, :show]
    end
  end
end