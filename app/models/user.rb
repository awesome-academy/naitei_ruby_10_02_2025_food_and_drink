class User < ApplicationRecord
  validates :name, presence: true,
            length: {maximum: Settings.max_name_length}
  validates :email, presence: true,
            length: {maximum: Settings.max_email_length},
            format: {with: Regexp.new(Settings.valid_email_regex)},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
            length: {minimum: Settings.min_password_length}
  has_secure_password
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :messages, class_name: Message.name,
            foreign_key: :sender_id, dependent: :destroy
  has_many :send_chats, class_name: Chat.name,
            foreign_key: :sender_id, dependent: :destroy
  has_many :receive_chats, class_name: Chat.name,
            foreign_key: :receiver_id, dependent: :destroy
end
