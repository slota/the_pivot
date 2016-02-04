class AddOwnerIdToVenues < ActiveRecord::Migration
  def change
    add_reference :venues, :user, index: true, foreign_key: true
  end
end
