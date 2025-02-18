class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
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

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end
end
