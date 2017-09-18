module ApiExceptions  
  class ProjectModuleError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::ProjectModuleError;end
      class RoleMismatchError < ApiExceptions::ProjectModuleError;end      
  end
end  