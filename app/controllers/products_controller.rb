class ProductsController < ApplicationController
  before_action :find_product, only: :show
  def show
    return if @product

    flash[:danger] = t "product.product_not_found"
    redirect_to root_path
  end

  def index
    @categories = Category.all
    products = Product.by_category(params[:category_id])
    @pagy, @products = pagy products, limit: Settings.pagy_items
  end
  private
  def find_product
    @product = Product.find_by id: params[:id]
  end
end
