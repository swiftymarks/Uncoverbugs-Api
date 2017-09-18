module ApiExceptions  
  class NotificationSettingError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::NotificationSettingError;end
      class RoleMismatchError < ApiExceptions::NotificationSettingError;end      
      class NotFoundError < ApiExceptions::NotificationSettingError;end            
  end
end  