require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end
  let(:user) {create(:user)}
  let(:product) {create(:product)}

  describe "GET /api/v1/products:id" do
    # api_v1_product_path
    it 'return the product detail' do
      get api_v1_product_path(product), as: :json

      expect(response).to have_http_status(:success)
    end
  end
end
