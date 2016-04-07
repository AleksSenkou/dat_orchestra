# == Schema Information
#
# Table name: instruments
#
#  id                 :integer          not null, primary key
#  name               :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Instrument < ActiveRecord::Base
  has_many :member_intruments, dependent: :destroy

  has_attached_file :image,
    styles: { little: "100x100>" },
    path: ":rails_root/public/instruments/:id/:style_:filename",
    url: "/instruments/:id/:style_:filename"

  do_not_validate_attachment_file_type :image
end
