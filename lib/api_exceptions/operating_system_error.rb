module ApiExceptions  
  class OperatingSystemError < ApiExceptions::BaseException
      class RoleMismatchError < ApiExceptions::OperatingSystemError;end      
  end
end