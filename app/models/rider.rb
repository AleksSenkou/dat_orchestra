# == Schema Information
#
# Table name: riders
#
#  id                    :integer          not null, primary key
#  title                 :string
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#

class Rider < ActiveRecord::Base
  has_attached_file :document,
    styles: { thumb: [ "300x300>", :png ] },
    path: ":rails_root/public/riders/:id/:style_:filename",
    url: "/riders/:id/:style_:filename"

  validates_attachment :document, content_type: { content_type: "application/pdf" }
end
