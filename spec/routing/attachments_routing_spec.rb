require "rails_helper"

RSpec.describe AttachmentsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/attachments").to route_to("attachments#create")
    end

  end
end
