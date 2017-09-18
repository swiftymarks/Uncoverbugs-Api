require 'rails_helper'

RSpec.describe "Add platform", type: :request do
  describe 'POST /admins/platform/create' do
    context 'When given complete fields as company' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]

        add_platform_param = { platform: { name: "LG" }}.to_json
        post "http://localhost:3000/api/v1/admins/platforms/create", params: add_platform_param, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 201" do
        expect(response).to have_http_status :created
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["platform"]).not_to be_empty  
      end

      it "should have a db record" do
        json = JSON.parse(response.body)
        id = json["platform"]["id"]      
        platform = Platform.find(id)  
        expect(platform).not_to be_nil  
      end
    end

    context 'When invalid bearer' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]

        add_platform_param = { platform: {name: "LG" }}.to_json
        post "http://localhost:3000/api/v1/admins/platforms/create", params: add_platform_param, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXX' }
      end

      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'When resource used by a tester' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "tester")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]

        add_platform_param = { platform: {name: "LG" }}.to_json
        post "http://localhost:3000/api/v1/admins/platforms/create", params: add_platform_param, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
      end

      it "should respond with status 403" do
        expect(response).to have_http_status :bad_request
      end
    end

    context 'When resource used by a company' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "company")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]

        add_platform_param = { platform: {name: "LG" }}.to_json
        post "http://localhost:3000/api/v1/admins/platforms/create", params: add_platform_param, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
      end

      it "should respond with status 403" do
        expect(response).to have_http_status :bad_request
      end
    end
  end
end 