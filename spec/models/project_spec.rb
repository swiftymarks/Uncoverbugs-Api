require 'rails_helper'

RSpec.describe "Project Database Save" do
  user = FactoryGirl.build(:user_company)
  company = FactoryGirl.build(:company)
  project = FactoryGirl.build(:project)
  project.company = company
  project.save

  it "Is valid project to be save" do
    expect(project).to be_valid
  end
end