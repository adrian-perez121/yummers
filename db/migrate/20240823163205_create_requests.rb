class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.integer :requested_id

      t.timestamps
    end
  end
end
