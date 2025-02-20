class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: [:show, :update]
  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_owner, only: [:update]

  def show
    render json: @product
  end

  def create
    product = current_user.products.build(product_params)
  
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: {errors: @product.errors}, status: :unprocessable_entity
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def check_owner
    # Instead of:
    # render json: { error: "Forbidden" }, status: :forbidden
    # You just write:
    # head :forbidden only sets the HTTP status code (403 in this case) without rendering a response body.

    head :forbidden unless @product.user_id == current_user&.id
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end
end
