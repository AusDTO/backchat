require 'rails_helper'

RSpec.describe Output, :type => :model do
  it "has a valid factory" do
  	expect(build(:output)).to be_valid
  end

end