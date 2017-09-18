json.message @message
json.status @status
json.access_key @access_key        
json.user do
    json.first_name @user.first_name
    json.last_name  @user.last_name
    json.email      @user.email
    json.username   @user.username
    json.user_type  @user.user_type
end