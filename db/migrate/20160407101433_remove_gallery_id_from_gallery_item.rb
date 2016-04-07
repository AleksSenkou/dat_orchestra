class RemoveGalleryIdFromGalleryItem < ActiveRecord::Migration
  def change
    remove_column :gallery_items, :video_id
  end
end
