class UserSerializer < ActiveModel::Serializer
  attributes :admin?, :id, :handle, :image_url, :name
end
