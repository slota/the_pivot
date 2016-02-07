class PaperclipToConcert < ActiveRecord::Migration
  def change
    remove_column :concerts, :logo, :string
    add_column :concerts, :logo_file_name,    :string
    add_column :concerts, :logo_content_type, :string
    add_column :concerts, :logo_file_size,    :integer
    add_column :concerts, :logo_updated_at,   :datetime
  end
end
