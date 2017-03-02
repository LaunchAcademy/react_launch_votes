class Team < ApplicationRecord
  has_many :memberships
  has_many :nominations
  has_many :members, through: :memberships, source: :user

  validates_numericality_of :vote_threshold, greater_than: 0, only_integer: true
  validates_uniqueness_of :name

  scope :active, -> { where(active: true).order(:name) }

  def users
    (members + Team.admins.members).uniq
  end

  def self.admins
    find_or_create_by(name: "Admins")
  end
end
