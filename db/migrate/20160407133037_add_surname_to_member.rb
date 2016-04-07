class AddSurnameToMember < ActiveRecord::Migration
  def change
    add_column :members, :surname, :string
  end
end
