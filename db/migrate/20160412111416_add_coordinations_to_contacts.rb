class AddCoordinationsToContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :address_country
    remove_column :contacts, :address_city
    remove_column :contacts, :address_street

    add_column :contacts, :lat, :float
    add_column :contacts, :lng, :float
  end
end
