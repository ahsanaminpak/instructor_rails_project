# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :logged_in_user, only: [:new, :create]

  def index

  end
  

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def search
    # @result = User.search("ahsan")
    # @res = @result.records.first

    @result = User.search(params[:input]).records.first

    @name = @result.name
    @dept = @result.department
    @bio = @result.bio 


    # redirect_to users_sessions_search_results_path
    
  end

  def search_results

    @result = User.search(params[:input]).records.first

    @name = @result.name
    @dept = @result.department
    @bio = @result.bio 

  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
