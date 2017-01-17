require 'rails_helper'

RSpec.describe "chat_rooms/new", type: :view do
  before(:each) do
    assign(:chat_room, ChatRoom.new(
      :title => "MyString",
      :user => nil
    ))
  end

  it "renders new chat_room form" do
    render

    assert_select "form[action=?][method=?]", chat_rooms_path, "post" do

      assert_select "input#chat_room_title[name=?]", "chat_room[title]"

      assert_select "textarea#post[name=?]", "chat_room[post]"
    end
  end
end
