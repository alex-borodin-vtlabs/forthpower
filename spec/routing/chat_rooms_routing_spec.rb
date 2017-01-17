require "rails_helper"

RSpec.describe ChatRoomsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chat_rooms").to route_to("chat_rooms#index")
    end

    it "routes to #new" do
      expect(:get => "/chat_rooms/new").to route_to("chat_rooms#new")
    end

    it "routes to #show" do
      expect(:get => "/chat_rooms/1").to route_to("chat_rooms#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chat_rooms").to route_to("chat_rooms#create")
    end

  end
end
