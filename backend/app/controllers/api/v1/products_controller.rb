class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    render json: @product
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
