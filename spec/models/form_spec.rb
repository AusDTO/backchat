require 'rails_helper'

RSpec.describe Form, :type => :model do
  it "has a valid factory" do
  	expect(build(:form)).to be_valid
  end

end