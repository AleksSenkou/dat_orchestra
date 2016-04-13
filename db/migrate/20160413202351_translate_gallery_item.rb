class TranslateGalleryItem < ActiveRecord::Migration
  def self.up
    GalleryItem.create_translation_table!({
      title: :string
    }, {
      migrate_data: true
    })
  end

  def self.down
    GalleryItem.drop_translation_table! migrate_data: true
  end
end
