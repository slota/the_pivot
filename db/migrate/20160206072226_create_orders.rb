class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status 
      t.float :total_price
      t.references :user, index: true, foreign_key: true
      t.string :address

      t.timestamps null: false
    end
  end
end
