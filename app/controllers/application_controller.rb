class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.email == 'default@example.com'
      admins_path # or the path for your admin page
    elsif current_user.email.present?
      traders_path # or the path for your trader page
    else
      flash[:alert] = "You must create a user to access the traders index page."
    end
  end
end
