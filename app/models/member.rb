# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  first_name  :string
#  description :text
#  position    :integer
#  surname     :string
#
# Indexes
#
#  index_members_on_position  (position) UNIQUE
#

class Member < ActiveRecord::Base
  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :first_name, :surname, :description
  validates_length_of :description, maximum: 150

  has_one :picture, as: :imageable, dependent: :destroy
  has_and_belongs_to_many :compositions

  has_many :member_instruments, dependent: :destroy
  has_many :instruments, through: :member_instruments

  def avatar
    picture.image
  end
end
