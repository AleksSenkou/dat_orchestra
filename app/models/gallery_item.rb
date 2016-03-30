# == Schema Information
#
# Table name: gallery_items
#
#  id                  :integer          not null, primary key
#  name                :string
#  source_file_name    :string
#  source_content_type :string
#  source_file_size    :integer
#  source_updated_at   :datetime
#  position            :integer
#

class GalleryItem < ActiveRecord::Base
  default_scope { order(position: :asc) }

  acts_as_list

  has_attached_file :source,
    styles: lambda { |a| a.instance.is_image? ?
      { medium: "x300>", large: "1000x550>" }
      :
      { medium: { geometry: "300x300>", format: 'jpg' },
        large: { geometry: "1000x550>", format: 'jpg' },
        large_video: { geometry: "1000x550>", format: 'flv' }
      }
    },
    processors: lambda { |a| a.is_video? ? [:transcoder] : [:thumbnail] },
    path: ":rails_root/public/gallery_items/:id/:style_:filename",
    url: "/gallery_items/:id/:style_:filename"

  validates_attachment_presence :source

  validates_attachment_content_type :source,
    content_type: /\Avideo\/.*\Z/,
    if: :is_video?
  validates_attachment_content_type :source,
    content_type: /\Aimage\/.*\Z/,
    if: :is_image?

  def is_video?
    source.content_type =~ %r(video)
  end

  def is_image?
    source.content_type =~ %r(image)
  end
end
