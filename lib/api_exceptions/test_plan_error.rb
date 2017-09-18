module ApiExceptions  
  class TestPlanError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::TestPlanError;end
      class RoleMismatchError < ApiExceptions::TestPlanError;end      
      class DeviceNotFoundError < ApiExceptions::TestPlanError;end       
      class TestPlanNotFoundError < ApiExceptions::TestPlanError;end                  
  end
end  