require 'rails_helper'

RSpec.describe "Update tester profile", type: :request do
  describe 'PUT /users/profile/tester' do
    context 'Update tester profile to be valid' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        tester_profile_params = { user: { first_name: "Mark Kevin", last_name: "King" }, tester_profile: { address1: 'Manila City', address2: 'Makati City', province: 'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', born_year: 1991, gender: "male", skype_id: 'swiftymarks', paypal_email: 'king.mark.kevin@icloud.com'} }.to_json        
        put "http://localhost:3000/api/v1/users/profile/tester", params: tester_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["user"]).not_to be_empty        
        expect(json["tester_profile"]).not_to be_empty
        expect(json["company_profile"]).to be_nil
      end

      it "should have record in db" do
        json = JSON.parse(response.body)        
        email = json["user"]["email"]
        user = User.where(email: email).first
        expect(user.tester).not_to be_nil
        expect(user.tester.notification_setting).not_to be_nil        
      end
    end
    
    context 'Update tester profile to be invalid access key' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        
        tester_profile_params = { user: { first_name: "Mark Kevin", last_name: "King" }, tester_profile: { address1: 'Manila City', address2: 'Makati City', province: 'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', born_year: 1991, gender: "male", skype_id: 'swiftymarks', paypal_email: 'king.mark.kevin@icloud.com'} }.to_json        
        put "http://localhost:3000/api/v1/users/profile/tester", params: tester_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXXXX' }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end