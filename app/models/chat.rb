class Chat < ApplicationRecord
  belongs_to :sender, class_name: User.name
  belongs_to :receiver, class_name: User.name
  has_many :messages, dependent: :destroy
end
