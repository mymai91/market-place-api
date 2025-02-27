class OrderSerializer
  include JSONAPI::Serializer

  attributes :total
  
  belongs_to :user, serializer: UserSerializer
  has_many :products, serializer: ProductSerializer
end
