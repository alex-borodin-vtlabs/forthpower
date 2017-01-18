require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AttachmentsHelper. For example:
#
# describe AttachmentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  it "has resource class User" do
    expect(resource_class).to be(User)
  end
  it "has resource name user" do
    expect(resource_name).to eq(:user)
  end
  it "has resource" do
    expect(resource).to be_an_instance_of(User)
  end
  it "has devise mapping" do
    expect(devise_mapping).to eq(Devise.mappings[:user])
  end

  it "has gravatar url" do
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw")
    expect(gravatar_for(user)).to eq("<img alt=\"luke\" src=\"https://www.gravatar.com/avatar/2e5c8c61be4beb99af2f3c5fbb77e988?s=50\" />")
  end

  it "has avatar url" do
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw", avatar_url: "/kek.jpg")
    expect(gravatar_for(user)).to eq("<img alt=\"luke\" src=\"/kek.jpg\" />")
  end
end
