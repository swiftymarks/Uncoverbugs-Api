require 'rails_helper'

RSpec.describe "Fetch Notification Setting", type: :request do
  describe 'GET /notification_settings' do
    context 'Fetching notification settings with valid Bearer Token as Tester' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        tester_profile_params = { user: { first_name: "Mark Kevin", last_name: "King" }, tester_profile: { address1: 'Manila City', address2: 'Makati City', province: 'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', born_year: 1991, gender: "male", skype_id: 'swiftymarks', paypal_email: 'king.mark.kevin@icloud.com'} }.to_json        
        put "http://localhost:3000/api/v1/users/profile/tester", params: tester_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
        
        get "http://localhost:3000/api/v1/notification_settings", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["notification_setting"]).not_to be_empty
      end
    end

    context 'Fetching notification with invalid Bearer' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        get "http://localhost:3000/api/v1/notification_settings", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXXX' }        
      end
      
      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'Fetching notification as company' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        get "http://localhost:3000/api/v1/notification_settings", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 400" do
        expect(response).to have_http_status :bad_request
      end
    end
  end
end