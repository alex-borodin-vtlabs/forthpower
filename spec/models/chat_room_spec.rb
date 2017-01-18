require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryGirl.build(:valid_chat_room)).to be_valid
  end

  it "should have timestamp" do
    time = DateTime.current()
    room = FactoryGirl.create(:valid_chat_room)
    room.created_at = time
    expect(room.timestamp).to eq(time.strftime('%H:%M:%S %d %B %Y'))
  end

  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(1000).is_at_least(2) }
  it { should validate_presence_of(:user) }
  it { should have_many(:messages).dependent(:destroy) }

  it "should search" do
    first = FactoryGirl.create(:valid_chat_room, title: "Lol", post: "")
    second = FactoryGirl.create(:valid_chat_room, title: "Kek", post: "Lol")
    third = FactoryGirl.create(:valid_chat_room, title: "Kek", post: "Kek")
    expect(ChatRoom.search("Lol")).to eq [first, second]
  end
end
