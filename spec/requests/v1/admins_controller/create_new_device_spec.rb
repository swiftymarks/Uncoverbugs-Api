require 'rails_helper'

RSpec.describe "Add Brand", type: :request do
  describe 'POST /admins/devices/create' do
    context 'When given complete fields as admins' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        brand = Brand.new(name: "LG")
        platform = Platform.new(name: "Android")        
        operating_system = OperatingSystem.new(name: "Android 5.0 Lollipop")

        brand.save
        platform.save
        operating_system.save
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: "Android 5.0 Lollipop" }}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 201" do
        expect(response).to have_http_status :created
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["device"]).not_to be_empty       
      end
      
      it "should have a db record" do
        json = JSON.parse(response.body)
        id = json["device"]["id"]
        device = Device.find(id)  
        expect(device).not_to be_nil  
      end
    end
    
    context 'When not a valid platform' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        brand = Brand.new(name: "LG")
        platform = Platform.new(name: "Android")        
        operating_system = OperatingSystem.new(name: "Android 5.0 Lollipop")

        brand.save
        platform.save
        operating_system.save
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Some Platform", browser: "Google Chrome", operating_system: "Android 5.0 Lollipop" }}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 404" do
        expect(response).to have_http_status :not_found
      end
    end
    
    context 'When not a valid brand' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        brand = Brand.new(name: "LG")
        platform = Platform.new(name: "Android")        
        operating_system = OperatingSystem.new(name: "Android 5.0 Lollipop")

        brand.save
        platform.save
        operating_system.save
        
        add_device_params = { device: {brand: "Some Brand", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: operating_system.name }}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 404" do
        expect(response).to have_http_status :not_found
      end
    end
    
    context 'When not a valid operating system' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        brand = Brand.new(name: "LG")
        platform = Platform.new(name: "Android")        
        operating_system = OperatingSystem.new(name: "Android 5.0 Lollipop")

        brand.save
        platform.save
        operating_system.save
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: "Some Operating System"}}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 404" do
        expect(response).to have_http_status :not_found
      end
    end
    
    context 'When invalid bearer' do
      before(:each) do
        user = User.new(first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890', user_type: "admin")
        user.save
        signin_params = { user: { username: user.username, password: user.password } }.to_json
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: "Some Operating System"}}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXX' }
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
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: "Some Operating System"}}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
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
        puts signin_params
        post "http://localhost:3000/api/v1/authentications/signin_username", params: signin_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        add_device_params = { device: { brand: "LG", model: "G3" , platform: "Android", browser: "Google Chrome", operating_system: "Some Operating System"}}.to_json
        post "http://localhost:3000/api/v1/admins/devices/create", params: add_device_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
      end
      
      it "should respond with status 403" do
        expect(response).to have_http_status :bad_request
      end
    end
  end
end