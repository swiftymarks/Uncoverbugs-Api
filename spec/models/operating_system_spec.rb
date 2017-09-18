require 'rails_helper'

RSpec.describe "Operating System Database Save" do
  operating_system = FactoryGirl.create(:operating_system)

  it "Is valid operating system to be save" do
    expect(operating_system).to be_valid
  end

end