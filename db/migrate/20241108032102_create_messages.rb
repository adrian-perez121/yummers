class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true
      t.string :message
      t.integer :sender_id

      t.timestamps
    end
  end
end
