require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) {create(:user)}
  let(:product) {build(:product, user:)} #build product association with user

  describe 'validation' do
    it 'is valid attributes' do
      expect(product).to be_valid
    end

    it 'is invalid attributes' do
      product.title = nil
      expect(product).to_not be_valid
    end

    it 'should have positive price' do
      product.price = -1

      expect(product).to_not be_valid
    end
  end

  describe 'association' do
    it {should belong_to(:user)}
    it {should belong_to(:user)}
  end

  # TODO use Ransack or pg_search to build advanced search forms
  describe 'search scope' do
    let!(:tv_product_1) {create(:product, title: 'Plasma Samsung tv', price: 1000)}
    let!(:tv_product_2) {create(:product, title: 'Plasma Sony tv', price: 500)}  
    let!(:tv_product_3) {create(:product, title: 'Plasma Samsung 4K tv', price: 1300)}
    let(:laptop_product) {create(:product, :laptop)}
    let(:phone_product) {create(:product, :phone)}
    
    it 'should filter products by title' do
      expect(Product.filter_by_title('tv').count).to eq(3)
    end

    it 'should filter products by price above and sort them' do
      expect(Product.above_or_equal_to_price(1000).count).to eq(2)
      expect(Product.above_or_equal_to_price(1000).sort).to match_array([tv_product_1, tv_product_3])
    end

    it 'should filter products by price below and sort them' do
      expect(Product.below_or_equal_to_price(1000).count).to eq(2)
      expect(Product.below_or_equal_to_price(1000).sort).to match_array([tv_product_1, tv_product_2])
    end

    it 'should sort product by most recent' do
      expect(Product.recent).to match_array([tv_product_3, tv_product_2, tv_product_1, laptop_product, phone_product])
    end
  end
end
