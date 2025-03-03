class Order < ApplicationRecord
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  before_validation :set_total!

  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # ! is a convention helps indicate that the method is making a direct modification.
  # sum price via placements because Placements Store the Quantity of Each Product in the Order

  def set_total!
    # ❌ Without includes(:product) (N+1 Query Problem)
    # self.total = placements.sum { |placement| placement.quantity * placement.product.price }
    # SELECT * FROM placements WHERE order_id = 1;
    # SELECT * FROM products WHERE id = 2;
    # SELECT * FROM products WHERE id = 3;
    # SELECT * FROM products WHERE id = 4;
    # ❌ For every placement, Rails performs an extra query to fetch product.price.
    # ❌ This results in slow performance when handling many placements.

    # ✅ 2 Optimizing Queries with includes(:product)
    # self.total = placements.includes(:product).sum { |placement| placement.quantity * placement.product.price }
    # SELECT * FROM placements WHERE order_id = 1;
    # SELECT * FROM products WHERE id IN (2, 3, 4);
    # ✔ Only two queries instead of N+1!
    # ✔ Faster performance when calculating totals.


    self.total = self.placements.includes(:product).sum do |placement|
      placement.product.price * placement.quantity
    end
  end

  def build_placements_with_product_ids_and_quantities (placements)
    placements.each do |placement|
      self.placements.build(product_id: placement[:product_id], quantity: placement[:quantity])
    end

    yield self.placements if block_given?
  end
end
