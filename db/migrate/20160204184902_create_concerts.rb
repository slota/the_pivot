class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.date :date
      t.string :band
      t.string :logo
      t.integer :price
      t.references :venue, index: true, foreign_key: true
      t.string :genre
      t.string :url

      t.timestamps null: false
    end
  end
end
