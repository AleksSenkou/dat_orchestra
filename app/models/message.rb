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
#  viewed     :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  validates_presence_of :name, :email, :message

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  scope :not_viewed, -> { where(viewed: false) }
end
