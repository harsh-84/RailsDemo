class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :DOB, :Gender, :photo)}
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :DOB, :Gender, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :DOB, :Gender, :photo])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :DOB, :Gender, :photo])
  end
end
