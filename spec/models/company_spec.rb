require 'rails_helper'

RSpec.describe "Company Database Save" do
  user = FactoryGirl.create(:user_company)
  company = FactoryGirl.build(:company)  
  company.user = user
  company.save

  it "Is a valid company to be save" do
    expect(company).to be_valid
  end
end
