class OrdersController < ApplicationController
  before_action :logged_in_user?, only: %i(edit update view_history)
  before_action :correct_user, only: %i(edit update view_history)
  before_action :find_order, only: %i(edit update)
  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart = Cart.new current_user, session

    add_product_to_cart cart, product_id, quantity
    redirect_to product_path(product_id)
  end

  def show_cart
    @order = Order.find_by user_id: params[:user_id], status: :draft
    if @order.nil?
      flash[:danger] = t "order.cart_empty"
      redirect_to root_path
      return
    end

    @order_items = @order.order_items.includes :product
    product_ids = @order_items.map(&:product_id)
    @products = Product.by_ids product_ids
    @total_price = calculate_total_price @order_items
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

  def edit
    @order_items = @order.order_items.includes :product
    @products = Product.by_ids @order_items.map(&:product_id)
    @total_price = calculate_total_price @order_items
  end

  def update
    if @order.update order_params.merge(status: :pending)
      flash[:success] = t "order.pending"
      redirect_to root_path
    else
      @order_items = @order.order_items.includes :product
      @products = Product.by_ids @order_items.map(&:product_id)
      @total_price = calculate_total_price @order_items
      render :edit, status: :unprocessable_entity
    end
  end

  def view_history
    @pagy, @orders = pagy Order.by_user_id(params[:user_id])
                               .includes(:order_items)
                               .includes(:products)
                               .not_draft
                               .order_by_created_at,
                          limit: Settings.pagy_items
    @orders = @orders.by_status(params[:status]) if params[:status].present?
  end
  private

  def correct_user
    return if current_user.id == params[:user_id].to_i

    flash[:danger] = t "user.permission_denied"
    redirect_to root_path
  end

  def find_order
    @order = Order.find_by id: params[:id]
    return if @order&.status_draft?

    flash[:danger] = t "order.not_found"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

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
