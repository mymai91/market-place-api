# FactoryBot for testing

To use FactoryBot:

1. Add to Gemfile:

```
group :development, :test do
  gem 'factory_bot_rails'
end
```

Set up in `rails_helper.rb`:

```
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```
