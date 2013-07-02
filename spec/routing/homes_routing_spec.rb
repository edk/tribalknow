require "spec_helper"

describe HomesController do
  describe "routing" do

    it "routes to #index" do
      get("/homes").should route_to("homes#index")
    end

    it "routes to #new" do
      get("/homes/new").should route_to("homes#new")
    end

    it "routes to #show" do
      get("/homes/1").should route_to("homes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/homes/1/edit").should route_to("homes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/homes").should route_to("homes#create")
    end

    it "routes to #update" do
      put("/homes/1").should route_to("homes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/homes/1").should route_to("homes#destroy", :id => "1")
    end

  end
end
