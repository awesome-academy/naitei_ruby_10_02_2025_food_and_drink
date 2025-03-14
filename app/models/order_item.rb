class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than: Settings.min_quantity,
                           less_than: Settings.max_quantity}
  validates :unit_price, presence: true,
            numericality: {greater_than: Settings.min_price,
                           less_than: Settings.max_price}
end
