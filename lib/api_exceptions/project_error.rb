module ApiExceptions  
  class ProjectError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::ProjectError;end
      class RoleMismatchError < ApiExceptions::ProjectError;end      
      class NotFoundError < ApiExceptions::ProjectError;end            
  end
end  