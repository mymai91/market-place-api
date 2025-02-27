FactoryBot.define do
  factory :order do
    total { 0 }
    association :user

    # Create order with products using placements
    transient do
      product_count { 2 }
    end

    after(:create)  do |order, evaluator|
      products = create_list(:product, evaluator.product_count)
      products.each do |product|
        create(:placement, order: order, product: product)
      end
      order.update(total: products.sum(&:price))
      order.reload
    end
  end
end
