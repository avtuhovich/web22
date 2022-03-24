class ValueSerializer < ActiveModel::Serializer
  attributes :id, :user, :image, :value
end
