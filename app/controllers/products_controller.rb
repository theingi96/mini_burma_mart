class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category, image_attachment: :blob).order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end
end