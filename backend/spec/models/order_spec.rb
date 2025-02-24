require 'rails_helper'

RSpec.describe Order, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validation' do
    it 'total should be greater or equal to 0' do
      invalid_order = build(:order, total: -1)
      expect(invalid_order).to_not be_valid
    end

    it 'total should be present' do
      invalid_order = build(:order, total: nil)
      expect(invalid_order).to_not be_valid
    end
  end
end
