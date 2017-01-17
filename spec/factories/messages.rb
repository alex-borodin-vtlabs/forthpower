FactoryGirl.define do
  factory :message do
    body { Faker::StarWars.wookie_sentence }
    association :user, factory: :user
  end
end
