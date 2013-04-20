require 'spec_helper'

describe Post do
  context "validations" do
    it "should not allow bigger body size than 1000 characters" do
      body = ''
      1002.times { body << 'a' }
      post = Post.new(:body => body)
      post.should_not be_valid
      post.errors[:body].should be_include 'is too long (maximum is 1000 characters)'
    end
  end

  context "hooks" do
    it "builds title if specified in body with markdown" do
      post = Post.new(:body => "# Test title\nTest body", :title => nil)
      post.send :build_title
      post.title.should eq 'Test title'
      post.body.should eq 'Test body'
    end

    it "builds slug based on title" do
      post = Post.new(:title => 'Test title')
      post.send :build_slug
      post.slug.should eq 'test-title'
    end

    it "sets slug to timestamp if not title specified" do
      post = Post.new(:body => "Test")
      post.send :build_slug
      post.slug.should eq Time.now.strftime("%s") + ''
    end

    it "sets slug to timestamp plus id if no title specified during edit" do
      post = Factory.create(:post)
      post.title = nil
      post.send :build_slug
      post.slug.should eq Time.now.strftime("%s") + post.id.to_s
    end
  end
end
