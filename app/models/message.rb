class Message < ApplicationRecord
  belongs_to :sender, class_name: User.name
  belongs_to :chat
  validates :content, presence: true,
            length: {maximum: Settings.max_content_length}
end
