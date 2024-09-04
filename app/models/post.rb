class Post < ApplicationRecord
  @@min_length = 10
  @@max_length = 500

  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  has_one_attached :image

  default_scope { order(created_at: :desc)}

  validates :description, :author_id, :recipe, presence: true, on: [:create, :update]
  validates :description, :recipe, length: { in: @@min_length..@@max_length }

  def self.min_length
    @@min_length
  end

  def self.max_length
    @@max_length
  end
end
