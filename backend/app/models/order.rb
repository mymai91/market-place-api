class Order < ApplicationRecord
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  before_validation :set_total!

  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # ! is a convention helps indicate that the method is making a direct modification.
  def set_total!
    # prices = products.map(&:price) => create a new array => less efficient
    # prices = products.sum(&:price) => directly sum price without creating an array => more efficient
    self.total = products.sum(&:price)
  end
end
