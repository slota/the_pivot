class CreateVenuesTable < ActiveRecord::Migration
  def change
    create_table :venues_tables do |t|
      t.string :name
      t.string :status
      t.string :background_image
      t.string :city
      t.string :state
      t.string :address
    end
  end
end
