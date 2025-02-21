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
end
