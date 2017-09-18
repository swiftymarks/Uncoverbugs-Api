require 'rails_helper'

RSpec.describe "Testers Devices Database Save" do
  user = FactoryGirl.build(:user_tester)
  device = FactoryGirl.build(:device)
  tester = FactoryGirl.build(:tester_male)
  user.tester = tester
  tester.devices.push(device)
  device.testers.push(tester)
  user.save
  device.save

  it "Is valid testers devices to be save" do
    expect(tester).to be_valid
    expect(device).to be_valid
  end
end