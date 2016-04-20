class RemoveIndexesFromPositions < ActiveRecord::Migration
  def change
    remove_index :members, :position
    remove_index :compositions, :position
  end
end
