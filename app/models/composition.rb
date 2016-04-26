# == Schema Information
#
# Table name: compositions
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  position          :integer
#  song_file_name    :string
#  song_content_type :string
#  song_file_size    :integer
#  song_updated_at   :datetime
#

class Composition < ActiveRecord::Base
  translates :title, :description
  globalize_accessors

  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :title_ru, :title_en,
   :description_ru, :description_en,
   :position

  has_attached_file :song,
    path: ":rails_root/public/documents/music/:id/:filename",
    url: "/documents/music/:id/:filename"

  do_not_validate_attachment_file_type :song
  validates_attachment :song, presence: true

  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true, reject_if: :all_blank
  validates :picture, presence: true

  has_and_belongs_to_many :members

  alias_attribute :authors, :members

  def image
    picture.image
  end

  def authors_avatars
    authors.map(&:avatar)
  end
end
