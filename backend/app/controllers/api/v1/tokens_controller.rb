class Api::V1::TokensController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  def create
    @user = User.find_by_email(user_params[:email])

    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        email: @user.email
      }

    else
      head :unauthorized
    end

  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
