class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}, presence: true

  belongs_to :user

  def owner_by?(user)
    self.user == user
  end

  def self.search(params = {})
    products = params[:product_ids].present? ? Product.where(id: params[:product_ids]) : Product.all
    products = products.filter_by_title(params[:keyword]) if params[:keyword]
    products = products.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
    products = products.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
    products = products.recent if params[:recent]
    products
  end

  # Uses the -> (...) syntax, which is another way of writing a lambda.
  # The multi-line do ... end block is just for readability.
  # Otherwise, it behaves exactly like the first version.
  

  scope :filter_by_title, -> (keyword) do
    return nil if keyword.blank?
    where('lower(title) LIKE ?', "%#{keyword.downcase}%")
  end

  scope :above_or_equal_to_price, -> (price) do
    return nil if price.blank?

    where('price >= ?', price)
  end

  scope :below_or_equal_to_price, -> (price) do
    return nil if price.blank?

    where('price <= ?', price)
  end

  scope :recent, -> do
    order(:updated_at)
  end
end
