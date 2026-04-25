class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart || current_user.create_cart!
    @cart_items = @cart.cart_items.includes(product: [:category, { image_attachment: :blob }])

    if @cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    @subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
    @shipping_fee = 500
    @total = @subtotal + @shipping_fee

    @address = current_user.addresses.build
  end

  def create
    @cart = current_user.cart || current_user.create_cart!
    @cart_items = @cart.cart_items.includes(:product)

    if @cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
    shipping_fee = 500
    total = subtotal + shipping_fee

    ActiveRecord::Base.transaction do
      address = current_user.addresses.create!(address_params)

      order = current_user.orders.create!(
        address: address,
        total_amount: total,
        status: :pending
      )

      @cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          price: item.product.price,
          quantity: item.quantity
        )

        item.product.update!(stock: item.product.stock - item.quantity)
      end

      @cart_items.destroy_all

      redirect_to order_path(order), notice: "Order placed successfully."
    end
  rescue ActiveRecord::RecordInvalid => e
    @subtotal = subtotal || 0
    @shipping_fee = shipping_fee || 500
    @total = total || 0
    @address = current_user.addresses.build(address_params)

    flash.now[:alert] = e.message
    render :new, status: :unprocessable_entity
  end

  def index
    @orders = current_user.orders.includes(:address, order_items: :product).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.includes(order_items: :product, address: []).find(params[:id])
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :address_line, :building, :phone_number)
  end
end