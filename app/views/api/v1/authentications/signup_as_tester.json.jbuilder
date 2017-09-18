json.message @message
json.status @status
json.access_key @access_key
json.user do
    json.first_name @new_user.first_name
    json.last_name  @new_user.last_name
    json.email      @new_user.email
    json.username   @new_user.username
    json.user_type  @new_user.user_type
end