require 'rails_helper'

RSpec.describe "Notification Setting Save" do
  user_tester = FactoryGirl.build(:user_tester)
  tester = FactoryGirl.build(:tester_male)
  notification_setting = FactoryGirl.build(:notification_setting)
  user_tester.tester = tester
  tester.notification_setting = notification_setting
  user_tester.save
  
  it "Is valid notification setting to be save" do
    expect(notification_setting).to be_valid
  end
end