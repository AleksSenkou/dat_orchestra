class RemoveLatLngFromContact < ActiveRecord::Migration
  def change
    remove_column :contacts, :lat
    remove_column :contacts, :lng
  end
end
