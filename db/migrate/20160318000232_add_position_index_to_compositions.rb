class AddPositionIndexToCompositions < ActiveRecord::Migration
  def change
    add_index :compositions, :position, unique: true
  end
end
