class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"
  after_create_commit { broadcast_append_to self.chat }
  validates :message, presence: true
end
