class OrdersController < ApplicationController
  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart = Cart.new current_user, session

    add_product_to_cart cart, product_id, quantity
    redirect_to product_path(product_id)
  end

  private

  def add_product_to_cart cart, product_id, quantity
    success = if logged_in?
                cart.add_to_cart product_id, quantity
              else
                cart.add_to_cart_not_logged_in product_id, quantity
              end

    flash[success ? :success : :danger] =
      t("order.add_#{success ? 'success' : 'failed'}")
  end
end
