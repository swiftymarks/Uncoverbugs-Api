require 'rails_helper'

RSpec.describe "Add Project Module", type: :request do
  describe 'POST /project_modules' do
    context 'Fetching project modules completed' do
      before(:each) do
        params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, 
                   company_profile: { company_name: 'The App Snap', company_url: 'http://www.google.com'} }.to_json
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        create_project_params = { project: { name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com",
                                             objective: Faker::Lorem.sentence(100), language: Project.random_language, result_email: "user@mail.com"} }.to_json
        post "http://localhost:3000/api/v1/projects/create", params: create_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }

        json = JSON.parse(response.body)
        id = json["project"]["id"]
        project_module_params = { project_module: { project_id: id, name: Faker::Pokemon.name}  }.to_json
        post "http://localhost:3000/api/v1/project_modules/create", params: project_module_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }        
      end
      
      it "should respond with status 201" do
        expect(response).to have_http_status :created
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["project_module"]).not_to be_nil
      end

      it "should have a database record of" do
        json = JSON.parse(response.body)
        id = json["project_module"]["id"]
        project_module = ProjectModule.find(id)
        expect(json["project_module"]).not_to be_nil
      end
    end

    context 'Fetching project modules with invalid Bearer' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
        
        post "http://localhost:3000/api/v1/project_modules/create", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXXXX' }        
      end
      
      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end