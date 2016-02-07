class AddsPaperclipToUser < ActiveRecord::Migration
  def change
    remove_column :users, :picture, :string
    add_column :users, :image_file_name,    :string
    add_column :users, :image_content_type, :string
    add_column :users, :image_file_size,    :integer
    add_column :users, :image_updated_at,   :datetime
  end
end
