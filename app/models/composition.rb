# == Schema Information
#
# Table name: compositions
#
#  id          :integer          not null, primary key
#  name        :string
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

  validates_presence_of :name, :description

  has_one :picture, as: :imageable
end
