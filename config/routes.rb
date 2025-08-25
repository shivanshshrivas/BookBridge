Rails.application.routes.draw do
  resources :messages, only: [:index, :create]
  get "messages/thread/:listing_id/:user_id", to: "messages#show", as: :message_thread

  resources :transactions, only: [:index, :show, :update]
  resources :listings, only: [:index, :show]

  resources :listings do
    resources :saved_items, only: [:create, :destroy]
  end

  resources :my_listings, except: [:show]
  get "home/index"
  devise_for :users

  devise_scope :user do
    root to: "devise/registrations#new"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
