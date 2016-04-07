class CreateMemberInstruments < ActiveRecord::Migration
  def change
    create_table :member_instruments do |t|
      t.belongs_to :member, index: true
      t.belongs_to :instrument, index: true
    end
  end
end
