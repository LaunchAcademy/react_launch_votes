class NominationSerializer < ActiveModel::Serializer
  attributes :id, :body, :nominator_id, :nominee_id
end
