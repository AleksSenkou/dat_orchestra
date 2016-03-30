class CreateBasePages < ActiveRecord::Migration
  def change
    create_table :base_pages do |t|
      t.attachment :logo
      t.attachment :favicon
      t.attachment :hero_image
      t.attachment :dance_logo
      t.string :heading
      t.text :subheading
    end
  end
end
