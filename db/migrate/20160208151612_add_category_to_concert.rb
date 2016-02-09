class AddCategoryToConcert < ActiveRecord::Migration
  def change
    add_reference :concerts, :category, index: true, foreign_key: true
  end
end
