class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || current_user.create_cart!

    item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    item.quantity += 1 if item.persisted?

    item.save!

    redirect_to root_path, notice: "Added to cart."
  end

  def destroy
    item = CartItem.find(params[:id])
    item.destroy

    redirect_to cart_path
  end
end