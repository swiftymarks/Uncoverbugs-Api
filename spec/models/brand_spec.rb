require 'rails_helper'

RSpec.describe "Brand Database Save" do
  brand = FactoryGirl.create(:brand)
  brand.save

  it "Is valid brand to be save" do
    expect(brand).to be_valid
  end
end