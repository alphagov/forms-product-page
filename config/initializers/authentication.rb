Rails.application.config.before_initialize do
  # Configure OmniAuth authentication middleware
  # add Auth0 provider
  Rails.application.config.app_middleware.use(
    OmniAuth::Strategies::Auth0,
    ENV["SETTINGS__AUTH0__CLIENT_ID"],
    ENV["SETTINGS__AUTH0__CLIENT_SECRET"],
    ENV["SETTINGS__AUTH0__DOMAIN"],
    callback_path: "/auth/auth0/callback",
    authorize_params: {
      scope: "openid email",
    },
  )
end
