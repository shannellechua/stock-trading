class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  helper_method :admin?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :balance)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :balance)}
  end

  def admin?
    current_user&.email == 'r4nd0m08na@gmail.com'
  end

  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if admin?
      admin_users_path
    elsif current_user.email.present?
      transactions_path
    else
      flash[:alert] = "You must create a user to access the traders index page."
    end
  end
end