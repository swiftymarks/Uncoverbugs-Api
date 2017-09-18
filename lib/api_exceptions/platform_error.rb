module ApiExceptions  
  class PlatformError < ApiExceptions::BaseException
      class RoleMismatchError < ApiExceptions::PlatformError;end      
  end
end  