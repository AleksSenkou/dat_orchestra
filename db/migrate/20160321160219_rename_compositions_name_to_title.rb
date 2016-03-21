class RenameCompositionsNameToTitle < ActiveRecord::Migration
  def change
    rename_column :compositions, :name, :title
  end
end
