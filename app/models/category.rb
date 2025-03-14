class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  validates :name, presence: true,
            length: {maximum: Settings.max_category_name_length}
end
