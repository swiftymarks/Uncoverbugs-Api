require 'rails_helper'

RSpec.describe "User Database Save" do
  user = FactoryGirl.create(:user_company)
  
  it "Is valid user to be save" do
    expect(user).to be_valid
  end
end