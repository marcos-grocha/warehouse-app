Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines my roots

  root to: "home#index"
  resources :warehouses, only: [ :show, :new, :create, :edit, :update, :destroy ] do
    resources :stock_product_destinations, only: [ :create ]
  end

  resources :suppliers, only: [ :index, :show, :new, :create ]

  resources :product_models, only: [ :index, :show, :new, :create ]

  resources :orders, only: [ :index, :show, :new, :create, :edit, :update ] do
    resources :order_items, only: [ :new, :create ]
    get "search", on: :collection
    post "delivered", on: :member
    post "canceled", on: :member
  end

  devise_for :users
end
