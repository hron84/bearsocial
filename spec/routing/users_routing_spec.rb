require "spec_helper"

describe UsersController do
  describe "routing" do

    #it "routes to #index" do
    #  get("/users").should route_to("users#index")
    #end

    #it "routes to #new" do
    #  get("/users/new").should route_to("users#new")
    #end

    #it "routes to #show" do
    #  get("/users/1").should route_to("users#show", :id => "1")
    #end

    #it "routes to #edit" do
    #  get("/users/1/edit").should route_to("users#edit", :id => "1")
    #end

    #it "routes to #create" do
    #  post("/users").should route_to("users#create")
    #end

    #it "routes to #update" do
    #  put("/users/1").should route_to("users#update", :id => "1")
    #end

    #it "routes to #destroy" do
    #  delete("/users/1").should route_to("users#destroy", :id => "1")
    #end

    it 'routes to #follow' do
      put('/users/1/follow').should route_to('users#follow', :id => '1')
    end

    it 'routes to #unfollow' do
      put('/users/1/unfollow').should route_to('users#unfollow', :id => '1')
    end

    it 'routes to #friend' do
      put('/users/1/friend').should route_to('users#friend', :id => '1')
    end

    it 'routes to #unfriend' do
      put('/users/1/unfriend').should route_to('users#unfriend', :id => '1')
    end
  end
end
