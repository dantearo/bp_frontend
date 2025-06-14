Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Main application routes
  root "dashboard#index"
  
  get "dashboard", to: "dashboard#index"
  get "flight_requests", to: "flight_requests#index"
  get "flight_requests/:id", to: "flight_requests#show", as: :flight_request
  get "aircraft_fleet", to: "aircraft_fleet#index"
  get "vip_profiles", to: "vip_profiles#index"
  get "vip_profiles/:id", to: "vip_profiles#show", as: :vip_profile
  get "sources", to: "sources#index"
  get "reports", to: "reports#index"
  get "settings", to: "settings#index"
end
