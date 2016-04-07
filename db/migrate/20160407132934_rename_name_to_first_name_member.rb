class RenameNameToFirstNameMember < ActiveRecord::Migration
  def change
    rename_column :members, :name, :first_name
  end
end
