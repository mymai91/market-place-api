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

```
FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "Product #{n}" }
    price { rand(50..10_000).to_f }
    published { true }
    association :user # ✅ Ensures every product has a user

    trait :tv do
      title { "Super TV" }
    end

    trait :laptop do
      title { "Gaming Laptop" }
    end
  end
end
```

#### In the test case

```
  let(:tv_product_1) {create(:product, title: 'Plasma Samsung tv')}
  let(:tv_product_2) {create(:product, title: 'Plasma Sony tv')}
  let(:laptop_product) {create(:product, :laptop)}
  let(:phone_product) {create(:product, :phone)}
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

### Generate Model Rspec code

Use RSpec Generators (Automatic)

```
rails g rspec:model User
```

I will create

```
  create  spec/models/user_spec.rb

  create    spec/factories/users.rb
```

### Generate controller rspec

```
rails g rspec:controller Api::V1::Users
```

### Run the Test

Run all rspec test in your website

```
bundle exec rspec
```

Run only this specific file, use:

```
bundle exec rspec spec/controllers/api/v1/users_controller_spec.rb
```

## Add shoulda-matchers to your Gemfile:

```
group :test do
  gem 'shoulda-matchers', '~> 5.0'
end
```

run

```
bundle install
```

2. Configure shoulda-matchers in your rails_helper.rb:

Add the following to spec/rails_helper.rb after require 'rspec/rails':

```
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```

Test

```
it { should belong_to(:user) }
```
