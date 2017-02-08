require "factory_girl"

FactoryGirl.define do
  factory :user do
    email "carmilla@example.com"
    sequence(:github_id) { |n| n }
    sequence(:handle) { |n| "HeyCarmilla#{n}" }
    image_url "https://avatars.example.com"
    name "Carmilla Karnstein"

    trait :admin do
      after(:build) do |user|
        admin_team = create(:team, name: "Admins")
        create(:membership, team: admin_team, user: user)
      end
    end

    factory :admin_user, traits: [:admin]
  end
end
