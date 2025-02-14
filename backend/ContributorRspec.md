# FactoryBot for testing

## Step 1: Install RSpec and Factory Bot

1. Add these gems to your Gemfile:

```
# Gemfile
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'  # For generating fake data
end
```

Then run

```
bundle install
rails generate rspec:install
```

This will create:

- .rspec for RSpec configurations
- spec/ directory for test files
- spec/rails_helper.rb and spec/spec_helper.rb

## Step 2: Configure Factory Bot

```
mkdir -p spec/support
touch spec/support/factory_bot.rb
```

In spec/support/factory_bot.rb:

```
# spec/support/factory_bot.rb
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

Load the support file in rails_helper.rb:

```
# spec/rails_helper.rb
require 'support/factory_bot'
```

## Step 3: Create a factory

Generate the factor

```
rails generate factory_bot:model User
```

Edit the factory:

```
# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
  end
end
```

### Run test

run all tests:

```
rspec
```

To run specific test:

```
rspec spec/models/user_spec.rb
```

### Generate Rspec code

Use RSpec Generators (Automatic)

```
rails g rspec:model User
```

I will create

```
  create  spec/models/user_spec.rb

  create    spec/factories/users.rb
```
