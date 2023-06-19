class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :logged_in_user


    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :department, :bio])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :department, :bio])
    end

    def logged_in_user
        unless !current_user.nil?
           flash[:danger] = "Please log in."
           redirect_to new_user_session_path
        end
     end
end
