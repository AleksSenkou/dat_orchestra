class TranslateMember < ActiveRecord::Migration
  def self.up
    Member.create_translation_table!({
      first_name: :string,
      surname: :string,
      description: :text
    }, {
      migrate_data: true
    })
  end

  def self.down
    Member.drop_translation_table! migrate_data: true
  end
end
