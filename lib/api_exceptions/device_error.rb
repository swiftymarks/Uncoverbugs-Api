module ApiExceptions  
  class DeviceError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::DeviceError;end
      class RoleMismatchError < ApiExceptions::DeviceError;end      
      class NotFoundError < ApiExceptions::DeviceError;end            
  end
end  