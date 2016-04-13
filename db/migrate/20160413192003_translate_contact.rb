class TranslateContact < ActiveRecord::Migration
  def self.up
    Contact.create_translation_table!({
      name: :string
    }, {
      migrate_data: true
    })
  end

  def self.down
    Contact.drop_translation_table! migrate_data: true
  end
end
