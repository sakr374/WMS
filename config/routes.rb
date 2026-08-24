Rails.application.routes.draw do
  namespace :api do
    get 'readiness', to: 'readiness#index'
    get 'boot', to: 'boot#index'
    
    namespace :v1 do
      resources :inventories, only: [:index, :show]
      resources :kits, only: [:index, :show]
      resources :orders, only: [:index, :show]
    end
  end
end
