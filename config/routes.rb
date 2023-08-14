Rails.application.routes.draw do
  get :ping, controller: :heartbeat

  # Defines the root path route ("/")
  root "pages#index"

  get "/features" => "pages#features"
  get "/support" => "pages#support"
  get "/accessibility" => "pages#accessibility"
  get "/cookies" => "pages#cookies"
end
