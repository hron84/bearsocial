require 'spec_helper'

describe User do
  context "validations" do
    it "should not allow user without a name" do
      user = User.new
      user.should_not be_valid
      user.errors[:name].should_not be_empty
    end

    it "should not allow user without an email" do
      user = User.new
      user.should_not be_valid
      user.errors[:email].should_not be_empty
    end

    it "should not allow user without avatar URL" do
      user = User.new
      user.should_not be_valid
      user.errors[:avatar_url].should_not be_empty
    end

    it "should not allow user with invalid avatar URL" do
      user = User.new(:avatar_url => 'fubar')
      user.should_not be_valid
      user.errors[:avatar_url].should be_include 'is invalid'
    end
  end

  context "hooks" do
    it "should build avatar_url if email is specified" do
      user = User.new(:email => 'test@example.com')
      user.valid? # just trigger hook
      user.avatar_url.should eql 'https://gravatar.com/avatar/55502f40dc8b7c769880b10874abc9d0.png?r=pg'
    end
  end
end
