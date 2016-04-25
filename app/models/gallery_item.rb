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
  translates :title
  globalize_accessors

  default_scope { order(position: :asc) }

  acts_as_list

  validates_presence_of :position

  has_attached_file :image,
    styles: { medium: "x300>", large: "1000x550>" },
    path: ":rails_root/public/gallery/:id/:style_:filename",
    url: "/gallery/:id/:style_:filename"

  do_not_validate_attachment_file_type :image

  validates_attachment :image, presence: true, if: :is_image?

  validates :video_link, presence: true, if: :is_video?
  validate :validate_video_link_format, if: :has_video?

  validate :validate_resource_present, if: :new_record?

  def validate_resource_present
    unless has_image? or has_video?
      errors.add(:video_link, "Отсутствует ресурс(фото или видео)")
      errors.add(:image, "Отсутствует ресурс(фото или видео)")
    end
  end

  def validate_video_link_format
    errors.add(:video_link, "неверный формат") if video_id.nil?
  end

  def is_video?
    has_valid_video? or video_link_was
  end

  def is_image?
    has_image? or image_file_name_was
  end

  def has_image?
    image.exists? or image_file_name.present?
  end

  def has_video?
    video_link.present?
  end

  def has_valid_video?
    has_video? and video_id.present?
  end

  def url
    is_image? ? image.url(:large) : video_api_url
  end

  def thumbnail
    is_image? ? image.url(:medium) : video_thumbnail
  end

  def resource_file
    is_image? ? image_file_name : video_link
  end

  def video_api_url
    "//www.youtube.com/v/" + video_id
  end

  def video_thumbnail
    "http://img.youtube.com/vi/#{ video_id }/0.jpg"
  end

  def type
    is_image? ? I18n.t('active_admin.labels.photo') : I18n.t('active_admin.labels.video')
  end

  def self.with_type(type)
    all.select { |item| item.type.include?(type.to_s) }
  end

  ransacker :type,
    formatter: proc { |type|
      data = GalleryItem.with_type(type).map(&:id)
      data = data.present? ? data : nil
    }, splat_params: true do |parent|
      parent.table[:id]
    end

  private

  def video_id
    YoutubeID.from video_link
  end
end
