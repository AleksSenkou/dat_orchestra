# == Schema Information
#
# Table name: compositions_members
#
#  composition_id :integer
#  member_id      :integer
#
# Indexes
#
#  index_compositions_members_on_composition_id  (composition_id)
#  index_compositions_members_on_member_id       (member_id)
#

class CompositionsMembers < ActiveRecord::Base
end
