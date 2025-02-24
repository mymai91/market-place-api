require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end
  let(:user) {create(:user)}
  let(:token) {JsonWebToken.encode(user_id: user.id)}
  let(:authenticated_header) {{'Authorization' => token}}
  # let(:order) {create(:order, user: user)}
  # let(:order_2) {create(:order, user: user)}
  # let(:order_3) {create(:order, user: user)}

  describe "With authenticate" do
    before do
      3.times do |i|
        create(:order, user: user)
      end
    end
    describe "GET /index" do
      it 'returns a success response' do
        get api_v1_orders_path, headers: authenticated_header, as: :json
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:success)
        expect(json_response.dig(:data).length).to eq(3)
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
  end
end
