module ApiExceptions  
  class BrandError < ApiExceptions::BaseException
      class RoleMismatchError < ApiExceptions::BrandError;end      
  end
end