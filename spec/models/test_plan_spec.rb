require 'rails_helper'

RSpec.describe "Test Plan Database Save" do
  user = FactoryGirl.build(:user_company)
  company = FactoryGirl.build(:company)
  project = FactoryGirl.build(:project)
  test_plan = FactoryGirl.build(:test_plan_case_driven)
  user.company = company
  test_plan.project = project
  project.company = company
  user.save

  it "Is valid test plan to be save" do
    expect(test_plan).to be_valid
  end
end