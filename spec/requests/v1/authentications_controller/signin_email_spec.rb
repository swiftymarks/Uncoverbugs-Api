require 'rails_helper'

RSpec.describe "Sign in using email", type: :request do
  describe 'POST /authentications/signin_email' do
    context 'When given complete fields as company' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
        company_profile: { company_name: 'The App Snap', company_url: 'http://www.google.com'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        
        signin_params = { user: {email: 'king.mark.kevin@icloud.com', password: '1234567890'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_email", params: signin_params, headers: { 'Content-Type' => 'application/json' }
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["access_key"]).not_to be_empty
        expect(json["user"]).not_to be_empty
        expect(json["user"]["user_type"]).to eq('company')
        expect(json["access_key"]).not_to be_empty        
      end
    end
    
    context 'When given complete fields as tester' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
        tester_profile: {address1: 'Manila City', address2:'Makati City', province:'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', skype_id: 'swiftymarks'} }.to_json                   
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        
        signin_params = { user: {email: 'king.mark.kevin@icloud.com', password: '1234567890'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_email", params: signin_params, headers: { 'Content-Type' => 'application/json' }
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["access_key"]).not_to be_empty
        expect(json["user"]).not_to be_empty
        expect(json["user"]["user_type"]).to eq('tester')        
        expect(json["access_key"]).not_to be_empty        
      end
    end 

    context 'When given complete fields as admin' do
      before(:each) do
        user = User.new(first_name: "Mark Kevin", last_name: "King", email: "king.mark.kevin@icloud.com", username: "swiftymarks", password: "1234567890", user_type: "admin")
        user.save
        signin_params = { user: {email: 'king.mark.kevin@icloud.com', password: '1234567890'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_email", params: signin_params, headers: { 'Content-Type' => 'application/json' }
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["access_key"]).not_to be_empty
        expect(json["user"]).not_to be_empty
        expect(json["user"]["user_type"]).to eq('admin')        
        expect(json["access_key"]).not_to be_empty        
      end
    end
    
    context 'When invalid credentials' do
      before(:each) do        
        signin_params = { user: {email: 'lala@mail.com', password: '1234567890'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
      end
      
      it "should respond with status 404" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end