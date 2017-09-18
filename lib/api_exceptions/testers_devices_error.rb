module ApiExceptions  
  class TestersDevicesError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::TestersDevicesError;end
      class RoleMismatchError < ApiExceptions::TestersDevicesError;end      
      class NotFoundError < ApiExceptions::TestersDevicesError;end            
  end
end