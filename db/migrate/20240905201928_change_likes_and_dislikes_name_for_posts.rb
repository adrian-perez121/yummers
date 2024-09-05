class ChangeLikesAndDislikesNameForPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column(:posts, :likes, :like_counter)
    rename_column(:posts, :dislikes, :dislike_counter)
  end
end
