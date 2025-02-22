class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :email, :created_at
  has_many :products
end
