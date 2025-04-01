class OrderItem < ApplicationRecord
  UPDATE_QUANTITY_PARAMS = %i(quantity).freeze
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to: Settings.min_quantity,
                           less_than: Settings.max_quantity}
  validates :unit_price, presence: true,
            numericality: {greater_than: Settings.min_price,
                           less_than: Settings.max_price}
end
