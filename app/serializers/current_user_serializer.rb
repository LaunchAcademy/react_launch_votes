class CurrentUserSerializer < ActiveModel::Serializer
  attributes :admin?, :id, :name
  has_many :teams
end
