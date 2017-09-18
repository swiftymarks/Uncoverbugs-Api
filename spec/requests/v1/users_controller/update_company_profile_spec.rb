require 'rails_helper'

RSpec.describe "Update company profile", type: :request do
  describe 'PUT /users/profile/company' do
    context 'Update company profile to be valid' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' }}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        company_profile_params = { user: { first_name: 'Mark Kevin', last_name: 'King' }, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' }}.to_json
        put "http://localhost:3000/api/v1/users/profile/company", params: company_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["user"]).not_to be_empty        
        expect(json["tester_profile"]).to be_nil
        expect(json["company_profile"]).not_to be_empty
      end

      it "should have record in db" do
        json = JSON.parse(response.body)        
        email = json["user"]["email"]
        user = User.where(email: email).first
        expect(user.company).not_to be_nil
      end
    end
    
    context 'Update company profile to be invalid access key' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}}.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        
        company_profile_params = { company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' }}.to_json
        put "http://localhost:3000/api/v1/users/profile/tester", params: company_profile_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXXXX' }        
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end