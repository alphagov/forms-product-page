Rails.application.routes.draw do
  get :ping, controller: :heartbeat

  # Defines the root path route ("/")
  root "pages#index"

  get "/get-started" => "pages#get_started"
  get "/features" => "pages#features"
  get "/forthcoming-features" => "pages#forthcoming-features"
  get "/accessibility" => "pages#accessibility"
  get "/cookies" => "pages#cookies"
  get "/privacy" => "pages#privacy"

  get "/mailing-list" => redirect("https://service.us12.list-manage.com/subscribe?u=cb74eb9a6898b0e5870fede0a&id=451fe4c1e1")

  get "/support" => "support#support", as: :support
  post "/support" => "support#new", as: :new_support_message
  get "/support/help-using-forms" => "support#help_using_forms", as: :help_using_forms
  post "/support/help-using-forms" => "support#submit"
  get "/support/question-about-forms" => "support#question_about_forms", as: :question_about_forms
  post "/support/question-about-forms" => "support#submit"

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
