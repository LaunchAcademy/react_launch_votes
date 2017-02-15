class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :nominations
  has_many :users
end
