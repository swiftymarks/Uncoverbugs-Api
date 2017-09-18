require 'rails_helper'

RSpec.describe "Device Save" do
  device = FactoryGirl.build(:device)
  device.save
  
  it "Is valid notification setting to be save" do
    expect(device).to be_valid
  end
end