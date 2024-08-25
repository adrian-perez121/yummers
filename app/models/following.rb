class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validate :users_are_different

  private

  def users_are_different
    errors.add(:followee, 'cannot be the same as follower') if follower == followee
    errors.add(:follower, 'cannot be the same as followee') if follower == followee
  end
end
