json.message @message
json.status @status
json.user do
    json.first_name @current_user.first_name
    json.last_name  @current_user.last_name
    json.email      @current_user.email
    json.username   @current_user.username
    json.user_type  @current_user.user_type
end

if @current_user.tester                
    json.tester_profile do
        json.address1 @current_user.tester.address1
        json.address2 @current_user.tester.address2
        json.province @current_user.tester.province
        json.skype_id @current_user.tester.skype_id
        json.zip_code @current_user.tester.zip_code
        json.mobile_number @current_user.tester.mobile_number
        json.gender @current_user.tester.gender
        json.born_year @current_user.tester.born_year
        json.paypal_email @current_user.tester.paypal_email
    end
end

if @current_user.company
    json.company_profile do
        json.company_name @current_user.company.company_name
        json.company_url @current_user.company.company_url
    end
end