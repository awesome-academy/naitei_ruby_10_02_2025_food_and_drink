module OrdersHelper
  def cart_items_count
    if logged_in?
      pending_order = current_user.orders.find_by status: :pending
      pending_order&.order_items&.count || 0
    else
      session[:cart]&.count || 0
    end
  end
end
