require 'rails_helper'

RSpec.describe "Platform Database Save" do
  platform = FactoryGirl.create(:platform)
  platform.save

  it "Is valid platform to be save" do
    expect(platform).to be_valid
  end
end