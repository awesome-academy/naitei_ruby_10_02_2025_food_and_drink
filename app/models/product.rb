class Product < ApplicationRecord
  validates :name, presence: true,
            length: {maximum: Settings.max_product_name_length}
  validates :price, presence: true,
            numericality: {greater_than: Settings.min_price}
  validates :description, presence: true,
            length: {maximum: Settings.max_description_length}
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
end
