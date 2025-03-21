class Order < ApplicationRecord
  enum status: {
    pending: 0,
    confirmed: 1,
    delivered: 2,
    cancelled: 3
  }, _prefix: true

  validates :status, presence: true,
            inclusion: {in: statuses.keys}
  validates :total_price, presence: true,
            numericality: {greater_than_or_equal_to: Settings.min_price}
  validates :shipping_address, presence: true, allow_nil: true,
            length: {maximum: Settings.max_address_length}
  validates :phone_number, presence: true, allow_nil: true,
            length: {maximum: Settings.max_phone_length},
            format: {with: Regexp.new(Settings.valid_phone_regex)}
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
end
