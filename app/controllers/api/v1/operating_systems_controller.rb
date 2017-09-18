module Api
  module V1
    class OperatingSystemsController < ApplicationController
      before_action :authenticate_request   
      rescue_from  ApiExceptions::OperatingSystemError::RoleMismatchError, :with => :render_unauthorized
      
      def fetch_all_operating_systems
        @operating_systems = OperatingSystem.all
        @status = :ok
        @message = "Operating Systems Fetched"        
      end
    end
  end
end