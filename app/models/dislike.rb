class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :dislikeable, polymorphic: true

  validates :user, presence: true
end
