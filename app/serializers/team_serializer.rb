class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :nomination_placeholder
  has_many :nominations
  has_many :users

  def nomination_placeholder
    Nomination::PLACEHOLDERS.sample
  end
end
