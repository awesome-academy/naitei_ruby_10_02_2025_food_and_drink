class OrdersController < ApplicationController
  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart = Cart.new current_user, session

    add_product_to_cart cart, product_id, quantity
    redirect_to product_path(product_id)
  end

  def show_cart
    order = Order.find_by user_id: params[:user_id]
    if order.nil?
      flash[:danger] = t "order.not_found"
      redirect_to root_path
      return
    end

    cart = Cart.new current_user, session
    @order_items = order.order_items.includes :product
    product_ids = @order_items.map(&:product_id)
    @products = Product.by_ids product_ids
    @total_price = cart.total_price order
  end

  def show_guest_cart
    product_ids = session[:cart]&.keys
    @order_items = []
    if product_ids.present?
      @products = Product.by_ids product_ids
      products_index = @products.index_by(&:id)

      add_order_items products_index
      @total_price = calculate_total_price @order_items
    else
      @products = []
      @total_price = 0
    end
    render :show_cart
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

  def calculate_total_price order_items
    order_items.sum{|item| item.quantity * item.unit_price}
  end

  def add_order_items products_index
    session[:cart].each do |product_id, product_info|
      product = products_index[product_id.to_i]
      @order_items << OrderItem.new(
        product_id:,
        quantity: product_info["quantity"],
        unit_price: product.price
      )
    end
  end
end
