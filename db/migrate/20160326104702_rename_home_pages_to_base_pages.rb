class RenameHomePagesToBasePages < ActiveRecord::Migration
  def change
    rename_table :home_pages, :base_pages
  end
end
