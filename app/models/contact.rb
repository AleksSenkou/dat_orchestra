# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  email        :string
#  phone_number :string
#  name         :string
#  address      :string
#

class Contact < ActiveRecord::Base
  translates :name
  globalize_accessors

  validates_presence_of :name_ru, :name_en, :email, :phone_number, :address

  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true

  def avatar
    picture.image
  end

  def address
    Geocoder.address super, params: { language: I18n.locale }
  end

  def lat
    Geocoder.search(address)[0].latitude
  end

  def lng
    Geocoder.search(address)[0].longitude
  end
end
