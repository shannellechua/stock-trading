module Admin
    class AdminController < ApplicationController
      before_action :authenticate_admin!
      layout 'application'  # or 'admin' if you have a specific admin layout

      private

      def authenticate_admin!
        unless current_user&.email == 'r4nd0m08na@gmail.com'
          flash[:alert] = "You are not authorized to access this area."
          redirect_to transactions_path
        end
      end

      def require_admin
        unless current_user&.email == 'r4nd0m08na@gmail.com'
          flash[:alert] = "You must be an admin to perform this action."
          redirect_to transactions_path
        end
      end
    end
  end