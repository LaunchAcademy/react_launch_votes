class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :image_url, :name
end
