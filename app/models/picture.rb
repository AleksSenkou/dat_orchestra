# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_pictures_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
    path: ":rails_root/public/images/:id/:filename",
    url: "/images/:id/:filename"

  do_not_validate_attachment_file_type :image
end
