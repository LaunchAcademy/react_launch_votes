require "factory_girl"

FactoryGirl.define do
  factory :team do
    sequence(:launch_pass_id) { |n| 1 + n }
    sequence(:name) { |n| "#{n} Season #{Time.now.year}" }
  end
end
