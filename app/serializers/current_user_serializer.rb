class CurrentUserSerializer < ActiveModel::Serializer
  attributes :admin?, :id, :name, :presenter?
  has_many :teams
end
