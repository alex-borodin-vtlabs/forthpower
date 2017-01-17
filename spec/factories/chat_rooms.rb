FactoryGirl.define do
  factory :invalid_chat_room, class: ChatRoom do
    post { Faker::StarWars.wookie_sentence }
    association :user, factory: :author_user
    factory :valid_chat_room do
      title { Faker::StarWars.character }
    end
  end
end
