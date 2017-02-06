FactoryGirl.define do
  factory :membership do
    association :team
    association :user
  end
end
