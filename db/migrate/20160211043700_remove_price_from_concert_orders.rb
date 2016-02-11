class RemovePriceFromConcertOrders < ActiveRecord::Migration
  def change
    remove_column :concert_orders, :price, :float
  end
end
