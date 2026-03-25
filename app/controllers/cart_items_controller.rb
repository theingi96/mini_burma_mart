class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || current_user.create_cart!

    item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])

    if item.new_record?
      item.quantity = 1
    else
      item.quantity += 1
    end

    if item.save
      redirect_to cart_path, notice: "Added to cart."
    else
      redirect_to product_path(params[:product_id]), alert: "Could not add item to cart."
    end
  end

  def destroy
    cart = current_user.cart
    item = cart.cart_items.find(params[:id])
    item.destroy

    redirect_to cart_path, notice: "Item removed from cart."
  end
end