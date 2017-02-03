require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:github_uid) { |n| "ck#{n}" }
    sequence(:name) { |n| "Carmilla #{n} Karnstein" }
    sequence(:image_url) { |n| "https://avatars.example.com/u/#{n}" }
  end
end
