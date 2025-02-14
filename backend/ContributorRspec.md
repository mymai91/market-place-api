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
