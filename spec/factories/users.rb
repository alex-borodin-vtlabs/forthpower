FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    role 0
    factory :admin_user do
      role 3
    end
    factory :moderator_user do
      role 2
    end
    factory :author_user do
      role 1
    end
  end
end
