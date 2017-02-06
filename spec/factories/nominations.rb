FactoryGirl.define do
  factory :nomination do
    body "Most Something"
    association :nominator, factory: :user
    association :nominee, factory: :user
    association :team
  end
end
