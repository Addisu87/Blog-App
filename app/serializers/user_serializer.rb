class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :posts, :comments, :likes
end
