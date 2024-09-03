class Comment < ApplicationRecord
  @@min_length = 5
  @@max_length = 200
  # As of now the plan is to keep comments one level deep
  belongs_to :post
  belongs_to :comment, optional: true
  belongs_to :author, class_name: 'User'
  has_many :comments

  validates :body, :post_id, :author_id, presence: true
  validates :body, length: { in: @@min_length..@@max_length }
end
