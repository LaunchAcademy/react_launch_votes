class Nomination < ApplicationRecord

  default_scope { by_nominee.newest_first }
  scope :by_nominee, -> { joins(:nominee).order('name') }
  scope :newest_first, -> { order(created_at: :desc) }

  belongs_to :nominator, class_name: "User"
  belongs_to :nominee, class_name: "User"
  belongs_to :team
  has_many :votes

  validates_presence_of :body, :nominator, :nominee, :team
  validate :users_belong_to_team

  def users_belong_to_team
    unless nominator.nil? || nominator.admin? || nominator.teams.include?(team)
      errors.add(:nominator, "must belong to team")
    end
    unless nominee.nil? || nominee.admin? || nominee.teams.include?(team)
      errors.add(:nominee, "must belong to team")
    end
  end

  def voter_ids
    votes.map(&:id)
  end
end
