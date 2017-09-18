module ApiExceptions  
    class BaseException < StandardError
        include ActiveModel::Serialization
        attr_reader :status, :code, :message
        
        ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error | failure", code: code, message: message}}
        ERROR_CODE_MAP = {
            "AuthenticationError::DuplicateEmailError" => ERROR_DESCRIPTION.call(1000, "The e-mail has been taken"),
            "AuthenticationError::DuplicateUsernameError" => ERROR_DESCRIPTION.call(1001, "The username has been taken"),
            "AuthenticationError::MySQLSaveError" => ERROR_DESCRIPTION.call(1002, "Cannot save to database"),
            "AuthenticationError::InvalidCredentials" => ERROR_DESCRIPTION.call(1003, "Invalid credentials"),

            "UserError::MySQLSaveError" => ERROR_DESCRIPTION.call(2000, "Cannot save to database"),  
            "UserError::NoTesterProfileYetError" => ERROR_DESCRIPTION.call(2001, "User has no tester profile yet"),            
            

            "DeviceError::MySQLSaveError" => ERROR_DESCRIPTION.call(3000, "Cannot save to database"),            
            "DeviceError::RoleMismatchError" => ERROR_DESCRIPTION.call(3001, "Role Mismatch"),
            "DeviceError::NotFoundError" => ERROR_DESCRIPTION.call(3002, "Device not found"),            

            "ProjectError::MySQLSaveError" => ERROR_DESCRIPTION.call(4000, "Cannot save to database"),            
            "ProjectError::RoleMismatchError" => ERROR_DESCRIPTION.call(4001, "Role Mismatch"),
            "ProjectError::NotFoundError" => ERROR_DESCRIPTION.call(4002, "Device not found"),

            "NotificationSettingError::MySQLSaveError" => ERROR_DESCRIPTION.call(5000, "Cannot save to database"),            
            "NotificationSettingError::RoleMismatchError" => ERROR_DESCRIPTION.call(5001, "Role Mismatch"),
            "NotificationSettingError::NotFoundError" => ERROR_DESCRIPTION.call(5002, "Notification Setting not found")    , 

            "TestPlanError::MySQLSaveError" => ERROR_DESCRIPTION.call(5000, "Cannot save to database"),            
            "TestPlanError::RoleMismatchError" => ERROR_DESCRIPTION.call(5001, "Role Mismatch"),
            "TestPlanError::DeviceFoundError" => ERROR_DESCRIPTION.call(5002, "Device not found"),
            "TestPlanError::TestPlanFoundError" => ERROR_DESCRIPTION.call(5003, "Test Plan not found"),
            
            "ProjectModuleError::MySQLSaveError" => ERROR_DESCRIPTION.call(6000, "Cannot save to database"),            
            "ProjectModuleError::RoleMismatchError" => ERROR_DESCRIPTION.call(6001, "Role Mismatch"),

            "AdminsError::MySQLSaveError" => ERROR_DESCRIPTION.call(10000, "Cannot save to database"),  
            "AdminsError::RoleMismatchError" => ERROR_DESCRIPTION.call(10001, "Role Mismatch"),
            "AdminsError::BrandNotFound" => ERROR_DESCRIPTION.call(10001, "Brand Not Found"),            
            "AdminsError::PlatformNotFound" => ERROR_DESCRIPTION.call(10001, "Platform Not Found"),
            "AdminsError::OperatingSystemNotFound" => ERROR_DESCRIPTION.call(100002, "Operating System Not Found")  
            
            

        }
    
        def initialize
            error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
            ApiExceptions::BaseException::ERROR_CODE_MAP.fetch(error_type, {}).each do |attr, value| 
                instance_variable_set("@#{attr}".to_sym, value)
            end
            puts exception.backtrace            
        end
    end
end