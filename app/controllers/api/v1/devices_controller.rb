module Api
  module V1
    class DevicesController < ApplicationController
      before_action :authenticate_request   
      rescue_from  ApiExceptions::DeviceError::RoleMismatchError, :with => :render_unauthorized
      
      def fetch_all_devices
        @devices = Device.all
        @status = :ok
        @message = "Devices Fetched"        
      end
    end
  end
end