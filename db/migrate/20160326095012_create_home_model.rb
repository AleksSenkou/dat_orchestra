class CreateHomeModel < ActiveRecord::Migration
  def change
    create_table :home_pages do |t|
      t.attachment :logo
      t.attachment :favicon
      t.attachment :hero_image
      t.string :heading
      t.text :subheading
    end
  end
end
