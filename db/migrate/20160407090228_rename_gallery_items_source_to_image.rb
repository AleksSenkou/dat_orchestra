class RenameGalleryItemsSourceToImage < ActiveRecord::Migration
  def change
    rename_column :gallery_items, :source_file_name, :image_file_name
    rename_column :gallery_items, :source_file_size, :image_file_size
    rename_column :gallery_items, :source_content_type, :image_content_type
    rename_column :gallery_items, :source_updated_at, :image_updated_at
  end
end
