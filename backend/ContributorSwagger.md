#Swagger

# Install package

Gemfile

```

gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem 'rspec-rails'
  gem 'rswag-specs'
end
```

```
rails g rswag:api:install
rails g rswag:ui:install
RAILS_ENV=test rails g rswag:specs:install
```

# Add metadata

Navigate or create file `backend/spec/swagger_helper.rb`

```
# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Local server'
        }
      ]
    }
  }

  config.swagger_format = :yaml
end
```

# Generate controler test case

```
 rails g rspec:swagger Api::V1::Users
```

Then

```
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
```
