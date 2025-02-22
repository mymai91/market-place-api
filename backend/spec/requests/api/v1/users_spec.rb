require 'swagger_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }

  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'User ID'

      response '200', 'user found' do
        let(:id) { user.id }

        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     type: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         email: { type: :string },
                         created_at: { type: :string }
                       }
                     }
                   }
                 }
               }

        before do
          get api_v1_user_path(user), as: :json
        end

        it 'returns the correct user' do
          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:success)
          expect(json_response['data']['attributes']['email']).to eq(user.email)
        end

        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }

        before do
          get api_v1_user_path(id), as: :json
        end

        it 'returns a not found error' do
          expect(response).to have_http_status(:not_found)
        end

        run_test!
      end
    end
  end
end
