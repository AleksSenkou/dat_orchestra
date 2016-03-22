require "faker"
require "populator"

namespace :db do
  desc 'Fill database with sample data'
  task change_composition_images: :environment do
    clean_images
    make_pictures_for_compositions
  end
end

def clean_images
  Composition.all.each { |cm| cm.picture.destroy! }
end

def make_pictures_for_compositions
  Composition.all.each do |cm|
    imageable_id   = cm.id
    imageable_type = 'Composition'
    image          = sample_image

    Picture.create imageable_id: imageable_id, imageable_type: imageable_type, image: image
  end
end

def sample_image
  image_name = ['first.jpg', 'second.jpg', 'third.jpg', 'fourth.jpg'].sample

  path = Rails.root.join('app', 'assets', 'images', image_name)

  File.new(path)
end
