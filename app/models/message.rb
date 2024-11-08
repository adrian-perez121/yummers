class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"

  validates :message, presence: true
end
