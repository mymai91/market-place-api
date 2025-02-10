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