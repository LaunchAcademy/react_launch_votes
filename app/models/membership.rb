class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :team, scope: :user
end
