class Placement < ApplicationRecord
  belongs_to :order
  # inverse_of is used to explicitly declare the bidirectional (2 chieu) relationship between associations
  # you can define only on the belongs_to side enough because Rails is often smart enough to infer the inverse relationship automatically.
  # However, it's a good practice to define it explicitly to avoid any confusion.
  # defining inverse_of on both sides (Placement and Product)

  # Without inverse_of
  # product = Product.first
  # placement = product.placements.first
  # placement.product.object_id == product.object_id
  # => false (different objects in memory, Rails has to query again from the database. Rails phải truy vấn lại từ database)
  
  # With inverse_of
  # product = Product.first
  # placement = product.placements.first
  # placement.product.object_id == product.object_id
  # => true (same object in memory, Rails doesn't have to query again from the database. Rails không cần phải truy vấn lại từ database)
  belongs_to :product, inverse_of: :placements
end
