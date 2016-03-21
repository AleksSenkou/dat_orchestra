# == Schema Information
#
# Table name: compositions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  position    :integer
#
# Indexes
#
#  index_compositions_on_position  (position) UNIQUE
#

class Composition < ActiveRecord::Base
  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :title, :description

  has_one :picture, as: :imageable
  has_and_belongs_to_many :members

  alias_attribute :authors, :members

  def image
    picture.image
  end
end
