require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:user) {create(:user)}
  let(:user2) {create(:user )}
  let(:product) {create(:product, user: user)}
  let(:token) {JsonWebToken.encode(user_id: user.id)}

  let(:token2) {JsonWebToken.encode(user_id: user2.id)}

  before do
    @headers = { 'Authorization' => token }  # Set the token once
    @headers2 = { 'Authorization' => token2 }  # Set the token once
  end


  let(:valid_product) {{title: 'product 1', price: 100}}
  let(:invalid_product) {{ title: 'product invalid', price: -1}}

  describe "GET /api/v1/products:id" do
    # api_v1_product_path
    it 'return the product detail' do
      get api_v1_product_path(product), as: :json

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/v1/products" do
    it 'return the create product' do

      post api_v1_products_path(), params: {product: valid_product}, headers: @headers,
       as: :json

      expect(response).to have_http_status(:created)

      created_product = Product.last

      expect(created_product.title).to eq('product 1')
      expect(created_product.price).to eq(100)
    end
  end

  describe "PUT /api/v1/products/:id" do
    it 'only owner can update product' do
      put api_v1_product_path(product), params: { product: valid_product }, headers: @headers, as: :json

      expect(response).to have_http_status(:success)
      
      # put api_v1_product_path(product), params: {product: valid_product}, headers: @headers,
      #  as: :json

      # expect(response).to have_http_status(:success)

      product.reload # ensure database updated

      # expect(product.title).to eq('product 1')
      # expect(product.price).to eq(100)
    end

    it 'not owner can not update product' do
      put api_v1_product_path(product), params: {product: valid_product}, headers: @headers2, as: :json

      expect(response).to have_http_status(:forbidden)

      # put api_v1_product_path(product), params: {product: valid_product}, headers: @headers,
      #  as: :json

      # expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
