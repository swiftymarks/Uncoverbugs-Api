class AuthenticateUser
    prepend SimpleCommand 
    
    def initialize(email, username, password)
        @email = email 
        @username = username
        @password = password 
    end
    
    def call
        if @email
            JsonWebToken.encode(user_id: user_via_email.id) if user_via_email
        else
            JsonWebToken.encode(user_id: user_via_username.id) if user_via_username            
        end
    end 
    
    private
    
    attr_accessor :email, :password 
    
    def user_via_email 
        user = User.find_by_email(@email) 
        return user if user && user.authenticate(@password)
        errors.add :user_authentication, 'invalid credentials' 
        nil
    end
    
    def user_via_username 
        user = User.where(username: @username).first
        user = User.find_by_email(user.email)
        return user if user && user.authenticate(@password)
        errors.add :user_authentication, 'invalid credentials' 
        nil
    end
end