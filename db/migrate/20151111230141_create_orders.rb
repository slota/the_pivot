class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :total_price
      t.integer :user_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
