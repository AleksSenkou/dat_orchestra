class CreateCompositionsMembers < ActiveRecord::Migration
  def change
    create_table :compositions_members, id: false do |t|
      t.belongs_to :composition, index: true
      t.belongs_to :member, index: true
    end
  end
end
