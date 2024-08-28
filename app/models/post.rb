class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_one_attached :image

  default_scope { order(created_at: :desc)}

  validates :description, :author_id, :recipe, presence: true, on: [:create, :update]
  validates :description, :recipe, length: { in: 50..500 }
end
