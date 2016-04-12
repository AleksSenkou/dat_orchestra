# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  email        :string
#  phone_number :string
#  name         :string
#  lat          :float
#  lng          :float
#

class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :phone_number, :lat, :lng

  has_one :picture, as: :imageable, dependent: :destroy

  def avatar
    picture.image
  end
end
