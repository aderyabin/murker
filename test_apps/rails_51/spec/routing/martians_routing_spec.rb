require "rails_helper"

RSpec.describe MartiansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/martians").to route_to("martians#index")
    end

    it "routes to #new" do
      expect(:get => "/martians/new").to route_to("martians#new")
    end

    it "routes to #show" do
      expect(:get => "/martians/1").to route_to("martians#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/martians/1/edit").to route_to("martians#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/martians").to route_to("martians#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/martians/1").to route_to("martians#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/martians/1").to route_to("martians#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/martians/1").to route_to("martians#destroy", :id => "1")
    end

  end
end
