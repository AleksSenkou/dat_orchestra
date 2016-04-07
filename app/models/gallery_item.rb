# == Schema Information
#
# Table name: gallery_items
#
#  id                 :integer          not null, primary key
#  title              :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  position           :integer
#  video_link         :string
#

class GalleryItem < ActiveRecord::Base
  default_scope { order(position: :asc) }

  acts_as_list

  has_attached_file :image,
    styles: { medium: "x300>", large: "1000x550>" },
    path: ":rails_root/public/gallery/:id/:style_:filename",
    url: "/gallery/:id/:style_:filename"

  do_not_validate_attachment_file_type :image

  def is_video?
    not video_link.blank?
  end

  def is_image?
    image.exists?
  end

  def url
    is_image? ? image.url(:large) : video_api_url
  end

  def thumbnail
    is_image? ? image.url(:medium) : video_thumbnail
  end

  def video_api_url
    "//www.youtube.com/v/" + video_id
  end

  def video_thumbnail
    "http://img.youtube.com/vi/#{ video_id }/0.jpg"
  end

  private

  def video_id
    YoutubeID.from video_link
  end
end
