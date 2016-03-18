class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.text :description
      t.integer :position
    end

    add_index :members, :position, unique: true
  end
end
