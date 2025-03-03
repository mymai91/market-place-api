require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validation' do
    let(:user) {create(:user)}

    before do
      @order = build(:order, user: user)
      @product1 = create(:product, price: 10, quantity: 2)
      @product2 = create(:product, price: 20, quantity: 3)
    end

    it 'should set total' do
     
      order = create(:order, user: user)
    
      placement1 = create(:placement, order: order, product: @product1, quantity: 2)
      placement2 = create(:placement, order: order, product: @product2, quantity: 3)
    
      order.reload
      order.set_total!
    
      expect(order.total).to eq(2 * 10 + 3 * 20)  # ✅ Expect total to be 80
    end

    # it 'builds 2 placement for order' do
    #   @order.build_placements_with_product_ids_and_quantities([{product_id: @product1.id, quantity: 2}, {product_id: @product2.id, quantity: 3}])

    #   expect(@order.placements.size).to eq(2)
    # end
    
  end
end
