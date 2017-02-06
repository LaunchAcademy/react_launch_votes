require "factory_girl"

FactoryGirl.define do
  factory :user do
    email "carmilla@example.com"
    sequence(:github_id) { |n| n }
    sequence(:handle) { |n| "HeyCarmilla#{n}" }
    image_url "https://avatars.example.com"
    name "Carmilla Karnstein"
  end
end
