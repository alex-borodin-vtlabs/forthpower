require 'rails_helper'

RSpec.describe "chat_rooms/show", type: :view do
  before(:each) do
    room = FactoryGirl.create(:valid_chat_room)
    room.user = FactoryGirl.create(:author_user)
    room.messages = [FactoryGirl.create(:message), FactoryGirl.create(:message)]
    @chat_room = assign(:chat_room, room)
    @message = Message.new
  end
  context "user" do
    login_user_with_role(:user)

    it "renders post" do
      render
      expect(rendered).to have_content(@chat_room.title)
      expect(rendered).to have_content(@chat_room.post)
    end

    it "renders messages" do
      render
      expect(rendered).to have_content(@chat_room.messages[0].body)
      expect(rendered).to have_content(@chat_room.messages[1].body)
    end

    it "renders comment form" do
      render
      assert_select "#new_message", :count => 1
    end
  end

  context "not logged" do

    it "renders post" do
      render
      expect(rendered).to have_content(@chat_room.title)
      expect(rendered).to have_content(@chat_room.post)
    end

    it "renders messages" do
      render
      expect(rendered).to have_content(@chat_room.messages[0].body)
      expect(rendered).to have_content(@chat_room.messages[1].body)
    end

    it "not renders comment form" do
      render
      expect(rendered).to have_content('Please, login to leave comments.')
      assert_select "#new_message", :count => 0
    end
  end
end
