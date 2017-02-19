class Team < ApplicationRecord
  has_many :memberships
  has_many :nominations
  has_many :members, through: :memberships, source: :user

  validates_presence_of :name
  validates_uniqueness_of :launch_pass_id

  scope :active, -> { where(active: true).order(:name) }

  def users
    (members + Team.admins.members).uniq
  end

  def self.admins
    find_or_create_by(
      name: "Admins",
      launch_pass_id: 1
    )
  end
end
