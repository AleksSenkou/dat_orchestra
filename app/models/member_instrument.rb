# == Schema Information
#
# Table name: member_instruments
#
#  id            :integer          not null, primary key
#  member_id     :integer
#  instrument_id :integer
#
# Indexes
#
#  index_member_instruments_on_instrument_id  (instrument_id)
#  index_member_instruments_on_member_id      (member_id)
#

class MemberInstrument < ActiveRecord::Base
  belongs_to :member
  belongs_to :instrument
end
