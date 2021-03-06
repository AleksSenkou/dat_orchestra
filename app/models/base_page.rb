# == Schema Information
#
# Table name: base_pages
#
#  id                      :integer          not null, primary key
#  logo_file_name          :string
#  logo_content_type       :string
#  logo_file_size          :integer
#  logo_updated_at         :datetime
#  favicon_file_name       :string
#  favicon_content_type    :string
#  favicon_file_size       :integer
#  favicon_updated_at      :datetime
#  hero_image_file_name    :string
#  hero_image_content_type :string
#  hero_image_file_size    :integer
#  hero_image_updated_at   :datetime
#  heading                 :string
#  subheading              :text
#  dance_logo_file_name    :string
#  dance_logo_content_type :string
#  dance_logo_file_size    :integer
#  dance_logo_updated_at   :datetime
#  bg_color                :string
#  about_us                :text
#

class BasePage < ActiveRecord::Base
  PATH = ":rails_root/public/documents/images/base/"
  URL = "/documents/images/base/"

  translates :subheading, :about_us
  globalize_accessors

  validates_presence_of :heading, :subheading_ru, :subheading_en, :bg_color,
    :logo_file_name, :dance_logo_file_name, :favicon_file_name, :hero_image_file_name

  has_attached_file :logo,
    styles: { medium: "x50", big: "x100" },
    path: PATH + "logo_:style_:filename",
    url: URL + "logo_:style_:filename"

  has_attached_file :dance_logo,
    styles: { medium: "x60", big: "x100" },
    path: PATH + "dance_logo_:style_:filename",
    url: URL + "dance_logo_:style_:filename"

  has_attached_file :favicon,
    styles: { medium: "40x40>" },
    path: PATH + "favicon_:style_:filename",
    url: URL + "favicon_:style_:filename"

  has_attached_file :hero_image,
    styles: { medium: "1600x700#" },
    path: PATH + "hero_image_:style_:filename",
    url: URL + "hero_image_:style_:filename"

  do_not_validate_attachment_file_type :logo, :dance_logo, :favicon, :hero_image
end
