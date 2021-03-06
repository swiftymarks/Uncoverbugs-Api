require 'rails_helper'

RSpec.describe "Signup as Company", type: :request do
  describe 'POST /authentications/signup_as_company' do
    context 'When given complete fields' do
      before(:each) do
        params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
                   company_profile: { company_name: 'The App Snap', company_url: 'http://www.google.com'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: params, headers: { 'Content-Type' => 'application/json' }
      end

      it "should respond with status 201 (created)" do
        expect(response).to have_http_status :created
      end

      it "should have a response body of" do
        json = JSON.parse(response.body)
        expect(json["user"]).not_to be_empty
        expect(json["user"]["user_type"]).to eq('company')                
        expect(json["company_profile"]).not_to be_empty     
        expect(json["access_key"]).not_to be_empty         
      end

      it "should have record in db" do
        json = JSON.parse(response.body)        
        email = json["user"]["email"]
        user = User.where(email: email).first
        expect(user).not_to be_nil
        expect(user.id).not_to be_nil
        expect(user.first_name).not_to be_nil
        expect(user.last_name).not_to be_nil
        expect(user.email).not_to be_nil
        expect(user.username).not_to be_nil
        expect(user.user_type).not_to be_nil
        expect(user.user_type).to eq('company')
        expect(user.company).not_to be_nil        
      end
    end
  end
end