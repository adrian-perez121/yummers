class Comment < ApplicationRecord
  @@min_length = 5
  @@max_length = 300
  # As of now the plan is to keep comments one level deep
  belongs_to :post
  belongs_to :comment, optional: true
  belongs_to :author, class_name: 'User'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :dislikes, as: :dislikeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc)}

  validates :body, :post_id, :author_id, presence: true
  validates :body, length: { in: @@min_length..@@max_length }

  def self.min_length
    @@min_length
  end

  def self.max_length
    @@max_length
  end
end
