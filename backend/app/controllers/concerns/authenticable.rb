module Authenticable
  
  def current_user
    if @current_user
      return @current_user
    end

    header = request.headers['Authorization']

    if header.nil?
      return nil
    end

    decode = JsonWebToken.decode(header)

    @user = User.find(decode[:user_id]) rescue ActiveRecord::RecordNotFound
  end
end