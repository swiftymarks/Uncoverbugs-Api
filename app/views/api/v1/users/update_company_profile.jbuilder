json.message @message
json.status @status
json.user do
  json.first_name @current_user.first_name
  json.last_name  @current_user.last_name
  json.email      @current_user.email
  json.username   @current_user.username
  json.user_type  @current_user.user_type
end

json.company_profile do
  json.company_name @current_user.company.company_name
  json.company_url @current_user.company.company_url
end