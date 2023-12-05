class AuthenticationController < ApplicationController
  def sign_in
    redirect_to "https://#{ENV['SETTINGS__AUTH0__DOMAIN']}/authorize?response_type=token&client_id=#{ENV['SETTINGS__AUTH0__CLIENT_ID']}&connection=email&redirect_uri=#{Settings.forms_admin.base_url}/auth/auth0/callback", allow_other_host: true
  end
end
