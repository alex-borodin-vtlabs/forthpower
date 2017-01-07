require 'rails_helper'

RSpec.describe "chat_rooms/edit", type: :view do
  before(:each) do
    @chat_room = assign(:chat_room, ChatRoom.create!(
      :title => "MyString",
      :user => nil
    ))
  end

  it "renders the edit chat_room form" do
    render

    assert_select "form[action=?][method=?]", chat_room_path(@chat_room), "post" do

      assert_select "input#chat_room_title[name=?]", "chat_room[title]"

      assert_select "input#chat_room_user_id[name=?]", "chat_room[user_id]"
    end
  end
end
