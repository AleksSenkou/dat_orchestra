class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :imageable, polymorphic: true, index: true
      t.attachment :image
    end
  end
end
