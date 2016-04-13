class TranslateBasePage < ActiveRecord::Migration
  def self.up
    BasePage.create_translation_table!({
      subheading: :text
    }, {
      migrate_data: true
    })
  end

  def self.down
    BasePage.drop_translation_table! migrate_data: true
  end
end
