# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  email           :string
#  phone_number    :string
#  name            :string
#  address_country :string
#  address_city    :string
#  address_street  :string
#

class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :phone_number, :address_city, :address_country, :address_street

  has_one :picture, as: :imageable, dependent: :destroy

  def avatar
    picture.image
  end
end
