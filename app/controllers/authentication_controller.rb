class AuthenticationController < ApplicationController
  def callback_from_omniauth
    redirect_to "#{Settings.forms_admin.base_url}/auth/auth0", allow_other_host: true
  end
end
