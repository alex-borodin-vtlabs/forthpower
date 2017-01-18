require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:chat_room) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(1000).is_at_least(2) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:chat_room) }
end
