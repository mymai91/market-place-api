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
