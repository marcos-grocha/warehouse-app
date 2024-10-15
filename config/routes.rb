Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines my roots

  root to: "home#index"
  resources :warehouses, only: [ :show, :new, :create, :edit, :update, :destroy ]
  resources :suppliers, only: [ :index, :show, :new, :create ]
  resources :product_models, only: [ :index, :show, :new, :create ]

  devise_for :users
end
