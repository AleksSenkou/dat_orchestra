# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
  validates_presence_of :name, :email, :message
end
