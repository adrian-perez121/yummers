class ChangeCommentIdToBeNullableinComments < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :comment_id, true
  end
end
