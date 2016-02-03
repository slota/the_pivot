class CreateVenuesTable < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :status
      t.string :image
      t.string :city
      t.string :state
      t.string :address
      t.string :description
    end
  end
end
