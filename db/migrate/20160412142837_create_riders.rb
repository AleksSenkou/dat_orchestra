class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.string :title
      t.attachment :document
    end
  end
end
