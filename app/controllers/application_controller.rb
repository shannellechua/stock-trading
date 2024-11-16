class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

       def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :balance)}

            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :balance)}
       end
  
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
     if current_user.email == 'maylas02evandel@gmail.com'
       admin_users_path # or the path for your admin page
     elsif current_user.email.present?
       transactions_path # or the path for your trader page
     else
       flash[:alert] = "You must create a user to access the traders index page."
     end
   end
end

