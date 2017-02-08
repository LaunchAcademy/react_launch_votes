class Nomination < ApplicationRecord
  belongs_to :nominator, class_name: "User"
  belongs_to :nominee, class_name: "User"
  belongs_to :team

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
end
