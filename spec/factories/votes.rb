require "factory_girl"

FactoryGirl.define do
  factory :vote do
    nomination
    user
  end
end
