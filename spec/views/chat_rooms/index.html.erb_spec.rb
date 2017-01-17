require 'rails_helper'

RSpec.describe "chat_rooms/index", type: :view do
  context "author" do
    login_user_with_role(:author_user)
    before(:each) do
      room = FactoryGirl.create(:valid_chat_room)
      room.user = FactoryGirl.create(:author_user)
      assign(:chat_rooms, [
        room,
        room
      ])
    end

    it "renders a list of chat_rooms" do
      render
      assert_select ".card-title", :count => 2
      assert_select ".card-subtitle", :count => 2
      assert_select ".card-subtitle", :count => 2
      assert_select ".votes-container", :count => 2
      assert_select ".card-text", :count => 2
    end

    it "has new article button" do
      render
      expect(rendered).to have_content('New article')
    end
  end
  context "not logged" do
    before(:each) do
      room = FactoryGirl.create(:valid_chat_room)
      room.user = FactoryGirl.create(:author_user)
      assign(:chat_rooms, [
        room,
        room
      ])
    end
    it "renders a list of chat_rooms" do
      render
      assert_select ".card-title", :count => 2
      assert_select ".card-subtitle", :count => 2
      assert_select ".card-subtitle", :count => 2
      assert_select ".votes-container", :count => 2
      assert_select ".card-text", :count => 2
    end

    it "has new article button" do
      render
      expect(rendered).not_to have_content('New article')
    end
  end
end
