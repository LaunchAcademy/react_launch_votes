class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates_presence_of :team, :user
  validates_uniqueness_of :team, scope: :user
end
