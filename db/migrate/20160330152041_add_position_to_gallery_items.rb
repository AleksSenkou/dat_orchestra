class AddPositionToGalleryItems < ActiveRecord::Migration
  def change
    add_column :gallery_items, :position, :integer
  end
end
