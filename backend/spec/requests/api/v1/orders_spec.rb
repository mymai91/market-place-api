require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do

  let(:user) {create(:user)}
  let(:user_2) {create(:user)}
  let(:token) {JsonWebToken.encode(user_id: user.id)}
  let(:authenticated_header) {{'Authorization' => token}}


  # Create orders immediately (before tests run)
  product_count = 3
  let!(:order_1) { create(:order, user: user, product_count: product_count) }
  let!(:order_2) { create(:order, user: user) }
  let!(:order_3) { create(:order, user: user) }
  let!(:other_user_order) { create(:order, user: user_2) }

  describe "With authenticate" do
    describe "GET /index" do
      it 'returns a success response' do
        get api_v1_orders_path, headers: authenticated_header, as: :json
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response.dig(:data).length).to eq(3)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get api_v1_order_path(order_1), headers: authenticated_header, as: :json
        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:success)
        expect(json_response.dig(:data, :id)).to eq(order_1.id.to_s)
        expect(json_response.dig(:data, :relationships, :products, :data).length).to eq(product_count)
      end

      it 'returns not found' do
        get api_v1_order_path(other_user_order), headers: authenticated_header, as: :json

        expect(response).to have_http_status(:not_found)
      end

    end

    describe "POST /create" do
      let!(:product_1) {create(:product)}
      let!(:product_2) {create(:product)}
      it 'create order' do
        order_params = {
          order: {
            product_ids: [product_1.id, product_2.id],
            total: product_1.price + product_2.price
          }
        }
        post api_v1_orders_path, params: order_params, headers: authenticated_header, as: :json_response

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:created)
        expect(json_response.dig(:included).length).to eq(2)
        expect(json_response.dig(:data, :attributes, :total).to_f).to eq(order_params.dig(:order, :total))
      end
    end
  end

  describe "With unauthorized: forbidden" do
    describe "GET /index" do
      it 'returns unauthorized' do
        get api_v1_orders_path, headers: {}, as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET /show" do

      it 'return unauthorized' do
        get api_v1_order_path(order_1), headers: {}, as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
