class HumanSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :password_confirmation
end
