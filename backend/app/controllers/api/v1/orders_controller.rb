class Api::V1::OrdersController < ApplicationController
  before_action :find_order, only: [:show]
  def index
    @orders = current_user.orders
    render json: OrderSerializer.new(@orders).serializable_hash.to_json, status: :ok
  end

  def show
    if @order
      options = {include: [:products]}
      render json: OrderSerializer.new(@order, options).serializable_hash.to_json, status: :ok
    else
      render json: {errors: 'Order not found'}, status: :not_found
    end
  end

  def create
    order = current_user.orders.build(order_params)
    # :'products.user' because the new order.products may not be fully loaded after saving.
    options = {include: [:products]}
    if order.save
      render json: OrderSerializer.new(order, options).serializable_hash.to_json, status: :created
    else
      render json: {erros: order.errors}, status: :unprocessable_entity
    end
  end

  private

  def find_order
    @order = current_user.orders.find(params.require(:id))
  end

  def order_params
    #  List Symbols First
    params.require(:order).permit(:total, product_ids: [])
  end
end
