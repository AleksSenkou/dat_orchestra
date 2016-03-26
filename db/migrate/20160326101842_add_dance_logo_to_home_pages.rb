class AddDanceLogoToHomePages < ActiveRecord::Migration
  def change
    add_attachment :home_pages, :dance_logo
  end
end
