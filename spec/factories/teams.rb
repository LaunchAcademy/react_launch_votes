require "factory_girl"

FactoryGirl.define do
  factory :team do
    sequence(:launch_pass_id) { |n| n }
    sequence(:name) { |n| "#{n} Season #{Time.now.year}" }
  end
end
