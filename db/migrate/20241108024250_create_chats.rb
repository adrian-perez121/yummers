class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :chatter_1_id
      t.integer :chatter_2_id

      t.timestamps
    end
  end
end
