class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def generic
    user = User.from_omniauth env["omniauth.auth"]
    if user.persisted?
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :generic
  alias_method :google_oauth2, :generic
end
