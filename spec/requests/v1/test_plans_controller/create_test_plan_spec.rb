require 'rails_helper'

RSpec.describe "Fetch Test Plans", type: :request do
  describe 'POST /test_plans/create' do
    context 'Create test plan success' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
            
        create_project_params = { project: { name: "New Project", testing_type: Project.random_testing_type, version: "1.0.0", testing_site: "http://www.google.com",
                                             objective: Faker::Lorem.sentence(100), language: Project.random_language, result_email: "user@mail.com"} }.to_json
        post "http://localhost:3000/api/v1/projects/create", params: create_project_params, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
        json = JSON.parse(response.body)
        project_id = json["project"]["id"]     

        test_plans_param = { test_plan: { project_id: project_id, testing_url: "http://www.google.com", name: "New Test Plan", step_explanation: "Do this step", minimum_time: 1, is_fix: true, script_file: "http://www.google.com", testing_type: "explatory" } }.to_json
        post "http://localhost:3000/api/v1/test_plans/create", params: test_plans_param, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + access_key }
        
      end
      
      it "should respond with status 201" do
        expect(response).to have_http_status :created
      end
      
      it "should respond with body of" do
        json = JSON.parse(response.body)
        expect(json["test_plan"]).not_to be_empty
      end

      it "should have a database record of" do
        json = JSON.parse(response.body)
        id = json["test_plan"]["id"]
        test_plan = TestPlan.find(id)
        expect(test_plan).not_to be_nil        
      end
    end

    context 'Create test Invalid bearer' do
      before(:each) do
        signup_params = { user: { first_name: 'Mark Kevin', last_name: 'King', email:'king.mark.kevin@icloud.com', username: 'swiftymarks', password: '1234567890'}, company_profile: { company_name: 'The Company', company_url: 'http://www.google.com' } }.to_json 
        post "http://localhost:3000/api/v1/authentications/signup_as_company", params: signup_params, headers: { 'Content-Type' => 'application/json' }
        access_key = JSON.parse(response.body)["access_key"]
    
        get "http://localhost:3000/api/v1/test_plans", params: nil, headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer XXXXX' }
      end
      
      it "should respond with status 401" do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end