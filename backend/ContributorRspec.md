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
