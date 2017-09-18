require 'rails_helper'

RSpec.describe "Fetch All Devices", type: :request do
  describe 'GET /devices' do
    context 'Fetching All Devices completed' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        tester_profile_params = { user: { first_name: "Mark Kevin", last_name: "King" }, tester_profile: { address1: 'Manila City', address2: 'Makati City', province: 'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', born_year: 1991, gender: "male", skype_id: 'swiftymarks', paypal_email: 'king.mark.kevin@icloud.com'} }.to_json        
        put "http://localhost:3000/api/v1/users/profile/tester", params: tester_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
        
        get "http://localhost:3000/api/v1/devices", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["devices"]).not_to be_nil
      end
    end

    context 'Fetching all devices with invalid Bearer' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        get "http://localhost:3000/api/v1/devices", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXXX' }        
      end
      
      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end