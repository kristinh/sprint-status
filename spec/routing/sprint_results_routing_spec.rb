require "spec_helper"

describe SprintResultsController do
  describe "routing" do

    it "routes to #index" do
      get("/sprint_results").should route_to("sprint_results#index")
    end

    it "routes to #new" do
      get("/sprint_results/new").should route_to("sprint_results#new")
    end

    it "routes to #show" do
      get("/sprint_results/1").should route_to("sprint_results#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sprint_results/1/edit").should route_to("sprint_results#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sprint_results").should route_to("sprint_results#create")
    end

    it "routes to #update" do
      put("/sprint_results/1").should route_to("sprint_results#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sprint_results/1").should route_to("sprint_results#destroy", :id => "1")
    end

  end
end
