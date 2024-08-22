class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :description
      t.integer :author_id
      t.string :recipe
      t.integer :likes
      t.integer :dislikes

      t.timestamps
    end
  end
end
