# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  position    :integer
#
# Indexes
#
#  index_members_on_position  (position) UNIQUE
#

class Member < ActiveRecord::Base
  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :name, :description

  has_one :picture, as: :imageable
  has_and_belongs_to_many :compositions

  def avatar
    picture.image
  end
end
