class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.attachment :song
    end

    add_index :compositions, :position, unique: true
  end
end
