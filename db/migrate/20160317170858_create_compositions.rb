class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.string :name
      t.text :description
      t.integer :position
    end
  end
end
