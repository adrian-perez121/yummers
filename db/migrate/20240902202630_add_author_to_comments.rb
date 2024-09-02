class AddAuthorToComments < ActiveRecord::Migration[7.1]
  def change
    add_column(:comments, :author_id, :integer)
  end
end
