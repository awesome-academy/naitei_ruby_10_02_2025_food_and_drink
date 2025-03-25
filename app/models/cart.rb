class Cart
  attr_reader :user, :session

  def initialize user, session
    @user = user
    @session = session
  end

  def add_to_cart product_id, quantity
    product = Product.find_by id: product_id
    return false unless product

    order = find_or_create_pending_order quantity, product
    return false unless update_or_create_order_item(order, product_id,
                                                    quantity, product.price)

    update_total_price order
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def add_to_cart_not_logged_in product_id, quantity
    product_id = product_id.to_s
    product = Product.find_by id: product_id
    return false unless product

    session[:cart] ||= {}
    if session[:cart][product_id]
      session[:cart][product_id]["quantity"] += quantity
    else
      session[:cart][product_id] = {"quantity" => quantity}
    end
    true
  end

  def find_or_create_pending_order quantity, product
    @user.orders.find_or_create_by(user_id: @user.id,
                                   status: :pending) do |order|
      order.total_price = product.price * quantity
    end
  end

  def update_or_create_order_item order, product_id, quantity, product_price
    order_item = order&.order_items&.find_by(product_id:)
    if order_item
      update_order_item order_item, quantity
    else
      create_new_order_item order, product_id, quantity, product_price
    end
  end

  def update_order_item order_item, quantity
    order_item.update quantity: order_item.quantity + quantity
  end

  def create_new_order_item order, product_id, quantity, product_price
    order.order_items.create(product_id:, quantity:,
                             unit_price: product_price)
  end

  def update_total_price order
    order.update total_price: order.calculate_total_price
  end
end
