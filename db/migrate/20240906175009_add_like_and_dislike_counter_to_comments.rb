class AddLikeAndDislikeCounterToComments < ActiveRecord::Migration[7.1]
  def change
    add_column(:comments, :like_counter, :integer, default: 0)
    add_column(:comments, :dislike_counter, :integer, default: 0)
  end
end
