FactoryGirl.define do
  factory :nomination do
    body "Most Something"
    association :nominator, factory: :user
    association :nominee, factory: :user
    team

    after(:build) do |nomination|
      create(:membership, team: nomination.team, user: nomination.nominator)
      create(:membership, team: nomination.team, user: nomination.nominee)
    end
  end
end
