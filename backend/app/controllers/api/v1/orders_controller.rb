class Api::V1::OrdersController < ApplicationController
  def index

    @orders = current_user.orders
    render json: OrderSerializer.new(@orders).serializable_hash.to_json, status: :ok
  end
end
