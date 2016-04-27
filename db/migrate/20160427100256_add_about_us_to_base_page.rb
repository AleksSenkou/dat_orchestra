class AddAboutUsToBasePage < ActiveRecord::Migration
  def change
    add_column :base_pages, :about_us, :text
    BasePage.add_translation_fields! about_us: :text
  end
end
