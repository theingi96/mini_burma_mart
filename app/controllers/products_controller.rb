class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.includes(:category, image_attachment: :blob).order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :is_active, :category_id, :image)
  end
end