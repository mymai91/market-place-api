# Authentication

Stateless session

Setting up the authentication token

1. Install Jwt:

```
bundle add jwt
```

2. Test

Open rails console

```
token = JWT.encode({message: 'Hello World'}, 'my_secret_key')

JWT.decode(token, 'my_secret_key')
=> [{"message"=>"Hello World"}, {"alg"=>"HS256"}]
```

## Handle

1. Create file `lib/json_web_token.rb` to handle logic JsonWebtoken

```
class JsonWebToken

  SECRET_KEY = Rails.application.credentials.secret_key_base
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key)
  end

  def self.decode(token)
  decode = JWT.decode(token, secret_key).first

    # HashWithIndifferentAccess:
    # class provide by Rails which allows us to retrieve a value of a has with a symbol or string
    HashWithIndifferentAccess.new decoded

  rescue JWT::DecodeError
    nil
  end
end
```

2. Load the `lib` files in our application, must specify the lib folder in the list of Ruby on Rails `_autoload_s`

Navigate to `application.rb`

```
module Backend
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join('lib')
  end
end
```

## Secret key

### For development and test environments:

Rails 7 automatically generates a `secret_key_base` in `config/credentials.yml.enc`

You can edit it using

```
rails credentials:edit
```

This will open an editor where you can add any additional secrets you need. The `secret_key_base` will already be there `by default`.

### For production environment:

Set it as an environment variable:

```
RAILS_MASTER_KEY=your_master_key_here
```

### NOTE

- Make sure you have the master key in `config/master.key`

- Remember to never commit the master.key file to version control - it should be in your .gitignore.
