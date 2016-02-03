class CreateVenuesTable < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :status, default: 0
      t.string :image
      t.string :city
      t.string :state
      t.string :address
      t.string :description
      t.string :url
    end
  end
end
