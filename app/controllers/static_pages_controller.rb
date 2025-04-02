class StaticPagesController < ApplicationController
  def home
    @products = Product.featured_products
    @categories = Category.limit Settings.home_page_items
  end
end
