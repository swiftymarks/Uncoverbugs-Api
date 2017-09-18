module Api
  module V1
    class AuthenticationsController < ApplicationController
      rescue_from  ApiExceptions::AuthenticationError::DuplicateEmailError, :with => :render_unprocessable_entity
      rescue_from ApiExceptions::AuthenticationError::DuplicateUsernameError, :with => :render_unprocessable_entity
      rescue_from ApiExceptions::AuthenticationError::InvalidCredentials, :with => :render_unauthorized
      
      def signup_as_tester
        @user = User.where(email: user_params[:email]).first
        raise ApiExceptions::AuthenticationError::DuplicateEmailError.new if @user
        raise ApiExceptions::AuthenticationError::DuplicateUsernameError.new if @username    
        
        @new_user = User.new(user_params)
        @new_user.user_type = "tester"
        
        raise ApiExceptions::AuthenticationError::MySQLSaveError if !@new_user.save
        
        @message = "User Created"
        @status = :created
        @access_key = JsonWebToken.encode(user_id: @new_user.id) 
        render status: :created 
      end
      
      def signup_as_company
        @user = User.where(email: user_params[:email]).first
        @username = User.where(username: user_params[:username]).first
        raise ApiExceptions::AuthenticationError::DuplicateEmailError.new if @user
        raise ApiExceptions::AuthenticationError::DuplicateUsernameError.new if @username     
        
        @new_user = User.new(user_params)
        @new_user.user_type = "company"        
        @new_company = Company.new(company_params)
        @new_user.company = @new_company
        raise ApiExceptions::AuthenticationError::MySQLSaveError if !@new_user.save
        @new_user.save
        @message = "User Created"
        @status = :created
        @access_key = JsonWebToken.encode(user_id: @new_user.id) 
        render status: :created         
      end
      
      def signin_email
        command = AuthenticateUser.call(signin_email_params[:email], nil, signin_email_params[:password])
        raise ApiExceptions::AuthenticationError::InvalidCredentials.new if !command.success?
        @user = User.where(email: signin_email_params[:email]).first    
        @message = "Sign in Success!"
        @status = :ok       
        @access_key = command.result
      end
      
      def signin_username
        begin
          command = AuthenticateUser.call(nil, signin_username_params[:username], signin_username_params[:password])
        rescue
          raise ApiExceptions::AuthenticationError::InvalidCredentials.new
        end
        raise ApiExceptions::AuthenticationError::InvalidCredentials.new if !command.success?
        @user = User.where(username: signin_username_params[:username]).first   
        @message = "Sign in Success!"
        @status = :ok       
        @access_key = command.result
      end
      
      def signin_as_admin
        command = AuthenticateUser.call(nil, signin_username_params[:username], signin_username_params[:password])
        raise ApiExceptions::AuthenticationError::InvalidCredentials.new if !command.success?
        @user = User.where(username: signin_username_params[:username]).first   
        @message = "Sign in Success!"
        @status = :ok       
        @access_key = command.result
      end
      
      private
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
      end
      
      def company_params
        params.require(:company_profile).permit(:company_url, :company_name)
      end
      
      def signin_email_params
        params.require(:user).permit(:email, :password)        
      end
      
      def signin_username_params
        params.require(:user).permit(:username, :password)                
      end
    end
  end
end