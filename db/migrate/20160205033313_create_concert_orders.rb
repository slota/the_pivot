class CreateConcertOrders < ActiveRecord::Migration
  def change
    create_table :concert_orders do |t|
      t.references :concert, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity
      t.float :subtotal
    end
  end
end
