class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone_number
      t.string :name
      t.string :address_country
      t.string :address_city
      t.string :address_street
    end
  end
end
