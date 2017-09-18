module Api
  module V1
    class PlatformsController < ApplicationController
      before_action :authenticate_request   
      rescue_from  ApiExceptions::PlatformError::RoleMismatchError, :with => :render_unauthorized
      
      def fetch_all_platforms
        @platforms = Platform.all
        @status = :ok
        @message = "Platforms Fetched"        
      end
    end
  end
end