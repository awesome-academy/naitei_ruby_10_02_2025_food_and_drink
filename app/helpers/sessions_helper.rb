module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    sync_cart
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def sync_cart
    return unless session[:cart]

    session[:cart]&.each do |product_id, product_info|
      product_id = product_id.to_i
      quantity = product_info["quantity"].to_i
      cart = Cart.new current_user, session
      cart.add_to_cart product_id, quantity
    end
    session.delete :cart
  end
end
