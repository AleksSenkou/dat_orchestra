class TranslateCompositions < ActiveRecord::Migration
  def self.up
    Composition.create_translation_table!({
      title: :string,
      description: :text
    }, {
      migrate_data: true
    })
  end

  def self.down
    Composition.drop_translation_table! migrate_data: true
  end
end
