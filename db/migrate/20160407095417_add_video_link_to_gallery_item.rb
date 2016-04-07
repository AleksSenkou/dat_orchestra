class AddVideoLinkToGalleryItem < ActiveRecord::Migration
  def change
    add_column :gallery_items, :video_link, :string
  end
end
