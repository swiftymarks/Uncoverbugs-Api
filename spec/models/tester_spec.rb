require 'rails_helper'

RSpec.describe "Tester Database Save" do
  tester = FactoryGirl.build(:tester_male)
  user = FactoryGirl.build(:user_tester)
  tester.user = user
  tester.save

  it "Is valid tester to be save" do
    expect(user).to be_valid
  end
end