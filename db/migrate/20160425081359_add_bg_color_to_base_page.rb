class AddBgColorToBasePage < ActiveRecord::Migration
  def change
    add_column :base_pages, :bg_color, :string
  end
end
