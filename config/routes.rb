Rails.application.routes.draw do
  get :ping, controller: :heartbeat
end
