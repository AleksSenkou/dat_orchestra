class RenameGalleryItemsNameToTitle < ActiveRecord::Migration
  def change
    rename_column :gallery_items, :name, :title
  end
end
