require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:user) { create(:user) }
  let(:un_owner_user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:un_owner_token) { JsonWebToken.encode(user_id: un_owner_user.id) }
  let(:owner_headers) { { 'Authorization' => token } }
  let(:un_owner_headers) { { 'Authorization' => un_owner_token } }
  let(:product) { create(:product, user: user) }
  let(:valid_product) { { title: 'product 1', price: 100 } }
  let(:invalid_product) { { title: 'product invalid', price: -1 } }

  before do
    @product = create(:product, user: user)
  end


  describe "GET /api/v1/products/:id" do
    it 'returns the product detail' do
      get api_v1_product_path(product), as: :json

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/v1/products" do
    it 'creates a product' do
      post api_v1_products_path, params: { product: valid_product }, headers: owner_headers, as: :json

      expect(response).to have_http_status(:created)

      created_product = Product.last

      expect(created_product.title).to eq('product 1')
      expect(created_product.price).to eq(100)
    end
  end

  describe "PUT /api/v1/products/:id" do
    it 'allows only the owner to update the product' do
      put api_v1_product_path(product), params: { product: valid_product }, headers: owner_headers, as: :json

      expect(response).to have_http_status(:success)

      product.reload # Ensure database updates


      json_response = JSON.parse(response.body, symbolize_names: true)

      debugger
      # .dig deeply nested hashes without raising an error if a key is missing. 
      # json_response.dig(:data, :attributes, :title) === json_response['data']['attributes']['title']  
      # benifit of using dig is that it will not raise an error if a key is missing.

      expect(json_response.dig(:data, :attributes, :title)).to eq(valid_product[:title])
      expect(json_response.dig(:data, :attributes, :price).to_f).to eq(valid_product[:price])
    end

    it 'prevents a non-owner from updating the product' do
      put api_v1_product_path(product), params: { product: valid_product }, headers: un_owner_headers, as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "DELETE /api/v1/products/:id" do
    it 'allows only the owner to delete the product' do
      expect {
        delete api_v1_product_path(@product), headers: owner_headers, as: :json
      }.to change(Product, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'prevents a non-owner from deleting the product' do
      delete api_v1_product_path(product), headers: un_owner_headers, as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end
end
