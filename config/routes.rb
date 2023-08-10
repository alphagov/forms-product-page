Rails.application.routes.draw do
  get :ping, controller: :heartbeat

  # Defines the root path route ("/")
  root "pages#index"
end
