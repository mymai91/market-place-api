class ProductSerializer
  include JSONAPI::Serializer

  set_type :product
  attributes :title, :price, :published

  belongs_to :user, serializer: UserSerializer
end
