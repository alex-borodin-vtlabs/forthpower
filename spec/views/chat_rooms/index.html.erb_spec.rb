require 'rails_helper'

RSpec.describe "chat_rooms/index", type: :view do
  before(:each) do
    assign(:chat_rooms, [
      ChatRoom.create!(
        :title => "Title",
        :user => nil
      ),
      ChatRoom.create!(
        :title => "Title",
        :user => nil
      )
    ])
  end

  it "renders a list of chat_rooms" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
