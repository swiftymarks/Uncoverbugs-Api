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

if @user.tester                
    json.tester_profile do
        json.address1 @user.tester.address1
        json.address2 @user.tester.address2
        json.province @user.tester.province
        json.skype_id @user.tester.skype_id
        json.zip_code @user.tester.zip_code
        json.mobile_number @user.tester.mobile_number
        json.gender @user.tester.gender
        json.born_year @user.tester.born_year
        json.paypal_email @user.tester.paypal_email
    end
end

if @user.company
    json.company_profile do
        json.company_name @user.company.company_name
        json.company_url @user.company.company_url
    end
end