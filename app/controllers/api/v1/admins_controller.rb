module Api
  module V1
    class AdminsController < ApplicationController
      before_action :authenticate_request, :admin_check     
      rescue_from ApiExceptions::AdminsError::RoleMismatchError, :with => :render_bad_request   
      rescue_from ApiExceptions::AdminsError::MySQLSaveError, :with => :render_unauthorized
      rescue_from ApiExceptions::AdminsError::BrandNotFound, :with => :render_not_found   
      rescue_from ApiExceptions::AdminsError::PlatformNotFound, :with => :render_not_found 
      rescue_from ApiExceptions::AdminsError::OperatingSystemNotFound, :with => :render_not_found 
      
      
      def add_operating_system
        @new_operating_system = OperatingSystem.new(add_os_params)
        raise ApiExceptions::AdminsError::MySQLSaveError.new if !@new_operating_system.save
        @status = :created
        @message = "New operating system added"
        render status: :created         
      end
      
      def add_platform
        @new_platform = Platform.new(add_plaform_params)
        raise ApiExceptions::AdminsError::MySQLSaveError.new if !@new_platform.save
        @status = :created
        @message = "New Platform added"
        render status: :created         
      end

      def add_brand
        @new_brand = Brand.new(add_brand_params)
        raise ApiExceptions::AdminsError::MySQLSaveError.new if !@new_brand.save
        @status = :created
        @message = "New Platform added"
        render status: :created         
      end
      
      def create_new_device
        is_valid_brand(create_new_device_params[:brand])
        is_valid_platform(create_new_device_params[:platform])
        is_valid_operating_system(create_new_device_params[:operating_system])
        @new_device = Device.new(create_new_device_params)
        raise ApiExceptions::AdminsError::MySQLSaveError.new if !@new_device.save        
        @status = :created
        @message = "Device Created"
        render status: :created         
      end
      
      def update_device
        @device = Device.find(update_device_params[:id])
        if update_device_params[:brand]
          is_valid_brand(update_device_params[:brand])
          @device.brand = update_device_params[:brand]          
        end

        if update_device_params[:platform]
          is_valid_platform(update_device_params[:platform])     
          @device.platform = update_device_params[:platform]                    
        end

        if update_device_params[:operating_system]
          is_valid_operating_system(update_device_params[:operating_system])          
          @device.platform = update_device_params[:operating_system]                              
        end

        @status = :created
        @message = "Device Updated"
        
      end
      
      private
      def add_brand_params
        params.require(:brand).permit(:name)
      end

      def add_plaform_params
        params.require(:platform).permit(:name)
      end
      
      def add_os_params
        params.require(:operating_system).permit(:name)
      end
      
      def create_new_device_params
        params.require(:device).permit(:brand, :platform, :model, :browser, :operating_system)
      end
      
      def update_device_params
        params.require(:device).permit(:id, :brand, :platform, :model, :browser, :operating_system)
      end
      
      def admin_check
        raise ApiExceptions::AdminsError::RoleMismatchError.new if @current_user.user_type != "admin"    
      end

      def is_valid_brand(brand)
        brands = Brand.all
        brands.each do |b|
          if b.name == brand
            return true
          end
        end
        raise ApiExceptions::AdminsError::BrandNotFound.new    
      end
      
      def is_valid_platform(platform)
        platforms = Platform.all
        platforms.each do |p|
          if p.name == platform
            return true
          end
        end
        raise ApiExceptions::AdminsError::PlatformNotFound.new    
      end
      
      def is_valid_operating_system(operating_system)
        operating_systems = OperatingSystem.all
        operating_systems.each do |os|
          if os.name == operating_system
            return true
          end
        end
        raise ApiExceptions::AdminsError::OperatingSystemNotFound.new    
      end
    end
  end
end