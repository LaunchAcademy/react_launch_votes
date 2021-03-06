class Nomination < ApplicationRecord
  PLACEHOLDERS = [
    "Most Glorious Beard",
    "Best Flow",
    "Most Help Requests",
    "Fastest Typer",
    "Best Spectacles",
    "Best Accent",
    "Most Likely To `git push origin master -f`",
    "Breakable Toy Already Funded on Kickstarter"
  ]

  default_scope { where(archived: false).current_week.by_nominee.newest_first }

  belongs_to :nominator, class_name: "User"
  belongs_to :nominee, class_name: "User"
  belongs_to :team
  has_many :votes, dependent: :destroy

  validates_inclusion_of :archived, in: [true, false]
  validates_presence_of :body
  validates :body, length: { maximum: 160 }
  validate :nominator_not_nominee
  validate :users_belong_to_team

  scope :by_nominee, -> { joins(:nominee).order('name') }
  scope :by_votes, -> (vote_threshold) { where("votes_count >= ?", vote_threshold).order(:votes_count) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :current_week,
    -> { where("nominations.created_at > ?", Time.current.beginning_of_week) }
  scope :previous_weeks,
    -> { where("nominations.created_at < ?", Time.current.beginning_of_week) }

  def nominator_not_nominee
    unless nominator.nil? || nominee.nil?
      if nominator == nominee
        errors.add(:nominator, "can't nominate themself")
      end
    end
  end

  def users_belong_to_team
    unless nominator.nil? || nominator.admin? || nominator.teams.include?(team)
      errors.add(:nominator, "must belong to team")
    end
    unless nominee.nil? || nominee.admin? || nominee.teams.include?(team)
      errors.add(:nominee, "must belong to team")
    end
  end

  def voter_ids
    voter_ids = Hash.new
    votes.map { |vote| voter_ids[vote.user.id] = vote.id }
    voter_ids
  end
end
