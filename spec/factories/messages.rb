FactoryGirl.define do
  factory :message do
    body { Faker::StarWars.wookie_sentence }
    association :user, factory: :user
    association :chat_room, factory: :valid_chat_room
  end
end
