module ApiExceptions  
    class AuthenticationError < ApiExceptions::BaseException
        class DuplicateEmailError < ApiExceptions::AuthenticationError;end
        class DuplicateUsernameError < ApiExceptions::AuthenticationError;end
        class MySQLSaveError < ApiExceptions::AuthenticationError;end
        class InvalidCredentials < ApiExceptions::AuthenticationError;end        
    end
end  