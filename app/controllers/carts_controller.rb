class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart!
    @cart_items = @cart.cart_items.includes(product: [image_attachment: :blob, :category])

    @subtotal = @cart_items.sum do |item|
      item.product.price * item.quantity
    end

    @shipping_fee = @cart_items.any? ? 500 : 0
    @total = @subtotal + @shipping_fee
  end
end