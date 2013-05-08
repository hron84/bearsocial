require 'spec_helper'

describe Profile do
  context "validations" do
    it "should not allow unknown locale" do
      profile = Profile.new(:locale => 'und') # Unicode undefined
      profile.should_not be_valid
      profile.errors[:locale].should_not be_empty
    end
  end
end
