module ApiExceptions  
  class UserError < ApiExceptions::BaseException
      class MySQLSaveError < ApiExceptions::UserError;end
      class NoTesterProfileYetError < ApiExceptions::UserError;end      
  end
end  