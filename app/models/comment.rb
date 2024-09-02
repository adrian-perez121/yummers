class Comment < ApplicationRecord
  # As of now the plan is to keep comments one level deep
  belongs_to :post
  belongs_to :comment
  has_many :comments
end
