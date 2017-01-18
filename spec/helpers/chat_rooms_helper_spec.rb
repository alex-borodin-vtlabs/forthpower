require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ChatRoomsHelper. For example:
#
# describe ChatRoomsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ChatRoomsHelper, type: :helper do
  it "should return image" do
    chat_room = FactoryGirl.create(:valid_chat_room, post: "dsfsdfsdf <img src=\"/pic.jpg\">")
    expect(preview_image(chat_room)).to eq("<img src=\"/pic.jpg\" class=\"card-img-top\" style=\"max-width:100%\">")
  end
  it "should return image" do
    chat_room = FactoryGirl.create(:valid_chat_room, post: "<p>dsfsdfsdf <img src=\"/pic.jpg\"> rfferf erferfe erferfer erferf erferferf erferfer rtgtgtyhyu i7ujh5gt4 wedwedwed 76hyt erfer tyhtyhtyh erferferfe tyhtyhtyhtyh rtgrtgrtgrtg hyujujyujyujyujy rtgrtgrtgrt</p>")
    expect(preview_text(chat_room)).to eq("dsfsdfsdf  rfferf erferfe erferfer erferf erferferf erferfer rtgtgtyhyu i7ujh5gt4 wedwedwed 76hyt erfer tyhtyhtyh erferferfe tyhtyhtyhtyh rtgrtgrtgrtg hyujujyujyujyujy rtgrtgrtgrt")
  end
end
