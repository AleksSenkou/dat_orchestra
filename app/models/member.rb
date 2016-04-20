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
  translates :first_name, :surname, :description
  globalize_accessors

  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :first_name_ru, :first_name_en,
    :surname_ru, :surname_en,
    :description_ru, :description_en

  validates_length_of :description_ru, :description_en, maximum: 140

  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true, reject_if: :all_blank
  validates :picture, presence: true

  has_and_belongs_to_many :compositions

  has_many :member_instruments, dependent: :destroy
  has_many :instruments, through: :member_instruments

  def self.for_select
    includes(:translations).all.map { |m| "#{m.id}) #{m.first_name} #{m.surname}" }
  end

  def avatar
    picture.image
  end

  private

  def image_doesnt_exists
    binding.pry_remote
  end
end
