class Team < ApplicationRecord
  has_many :memberships
  has_many :nominations
  has_many :users, through: :memberships

  validates_presence_of :name
  validates_uniqueness_of :launch_pass_id
end
