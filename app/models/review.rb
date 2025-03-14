class Review < ApplicationRecord
  validates :rating, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to: Settings.min_rating,
                           less_than_or_equal_to: Settings.max_rating}
  validates :comment, presence: true,
            length: {maximum: Settings.max_comment_length}
  belongs_to :user
  belongs_to :product
end
