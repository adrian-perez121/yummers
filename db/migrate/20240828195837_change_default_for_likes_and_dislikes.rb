class ChangeDefaultForLikesAndDislikes < ActiveRecord::Migration[7.1]
  def up
      change_column_default :posts, :likes, 0
      change_column_default :posts, :dislikes, 0
    end

    def down
      change_column_default :posts, :dislikes, nil
      change_column_default :posts, :likes, nil
  end
end
