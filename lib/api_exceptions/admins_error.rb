module ApiExceptions  
  class AdminsError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::AdminsError;end
      class BrandNotFound < ApiExceptions::AdminsError;end        
      class OperatingSystemNotFound < ApiExceptions::AdminsError;end        
      class PlatformNotFound < ApiExceptions::AdminsError;end     
      class RoleMismatchError < ApiExceptions::AdminsError;end      
  end
end  