require 'rails_helper'

RSpec.describe "Update Project", type: :request do
  describe 'PUT /projects/update' do
    context 'Create new project completed' do
      before(:each) do
        sign_up_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
        company_profile: { company_name: 'The App Snap', company_url: 'http://www.google.com'} }.to_json        
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: sign_up_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        create_project_params = { project: { name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com", objective: Faker::Lorem.sentence(100),
                                             objective: Faker::Lorem.sentence(100), language: Project.random_language, result_email: "user@mail.com"} }.to_json
        post "http://localhost:3000/api/v1/projects/create", params: create_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        

        json = JSON.parse(response.body)
        id = json["project"]["id"]
        update_project_params = { project: { id: id, name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com", objective: Faker::Lorem.sentence(100),
        objective: Faker::Lorem.sentence(50), language: Project.random_language, result_email: "user@mail.com"} }.to_json
        put "http://localhost:3000/api/v1/projects/update", params: update_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
      end
      
      it "should respond with status 200" do
        expect(response).to have_http_status :ok
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["project"]).not_to be_nil
      end
    end

    context 'When resource used by a tester' do
      before(:each) do
        params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
        tester_profile: {address1: 'Manila City', address2:'Makati City', province:'Metro Manila', zip_code: 1006, mobile_number: '+639178221164', skype_id: 'swiftymarks'} }.to_json                   
        post "http://localhost:3000/api/v1/authentications/signup_as_tester", params: params, headers: { 'Content-Type' => 'application/json' }    
        access_key = JSON.parse(response.body)["access_key"]
             
        update_project_params = { project: { name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com",
                                             objective: Faker::Lorem.sentence(100), language: Project.random_language, result_email: "user@mail.com"} }.to_json
        
        put "http://localhost:3000/api/v1/projects/update", params: update_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end

      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end

    end

    context 'When has a invalid Bearer' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        update_project_params = { project: { name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com",
        objective: Faker::Lorem.sentence(100), language: Project.random_language, result_email: "user@mail.com"} }.to_json

        put "http://localhost:3000/api/v1/projects/update", params: update_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXX' }              
      end
      
      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end