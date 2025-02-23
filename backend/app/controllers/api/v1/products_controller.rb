class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :check_owner, only: [:update, :destroy]

  def index
    @products = Product.search(search_params)
    render json: ProductSerializer.new(@products).serializable_hash.to_json, status: :ok
  end

  def show
    render json: ProductSerializer.new(@product).serializable_hash.to_json
  end

  def create
    product = current_user.products.build(product_params)
  
    if product.save
      render json: ProductSerializer.new(product).serializable_hash.to_json, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serializable_hash.to_json, status: :ok
    else
      render json: {errors: @product.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    
    head :no_content
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

    # head :forbidden unless @product.owner_by?(current_user)
    unless @product.owner_by?(current_user)
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def search_params
    params.permit(:keyword, :min_price, :max_price, :recent, :product_ids)
  end
end
