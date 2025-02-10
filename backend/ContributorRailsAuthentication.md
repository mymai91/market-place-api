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

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key)
  end

  def self.decode(token)
    decode = JWT.decode(token, secret_key).first

    # HashWithIndifferentAccess:
    # class provide by Rails which allows us to retrieve a value of a has with a symbol or string
    HashWithIndifferentAccess.new decoded

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
