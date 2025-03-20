class Product < ApplicationRecord
  validates :name, presence: true,
            length: {maximum: Settings.max_product_name_length}
  validates :price, presence: true,
            numericality: {greater_than: Settings.min_price}
  validates :description, presence: true,
            length: {maximum: Settings.max_description_length}
  validates :image,
            content_type: {
              in: Settings.image_types,
              message: I18n.t("product.image_format")
            },
            size: {
              less_than: Settings.max_image_size.megabytes,
              message: I18n.t("product.image_size")
            }
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  scope :by_category, lambda {|category_id|
    if category_id.present?
      joins(:product_categories).where(product_categories: {category_id:})
    end
  }

  def price_in
    case I18n.locale
    when :en
      price * I18n.t("exchange_rate.vnd_to_usd")
    else
      price * I18n.t("exchange_rate.usd_to_vnd")
    end
  end
end
