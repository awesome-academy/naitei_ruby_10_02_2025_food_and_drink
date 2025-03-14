class ProductsController < ApplicationController
  def index
    @categories = Category.all
    products = Product.by_category(params[:category_id])
    @pagy, @products = pagy products, limit: Settings.pagy_items
  end
end
