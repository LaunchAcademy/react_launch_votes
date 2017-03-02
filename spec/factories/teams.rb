require "factory_girl"

FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "#{n} Season #{Time.now.year}" }
  end
end
