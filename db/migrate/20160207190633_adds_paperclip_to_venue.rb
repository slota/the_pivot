class AddsPaperclipToVenue < ActiveRecord::Migration
  def change
    remove_column :venues, :image, :string
    add_column :venues, :image_file_name,    :string
    add_column :venues, :image_content_type, :string
    add_column :venues, :image_file_size,    :integer
    add_column :venues, :image_updated_at,   :datetime
  end
end
