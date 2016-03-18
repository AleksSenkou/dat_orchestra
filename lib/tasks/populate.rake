require "faker"
require "populator"

COMPOSITIONS_COUNT = 10

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    clean_database
    make_compositions
    make_pictures_for_compositions
  end
end

def clean_database
  [Composition].each(&:delete_all)
end

def make_compositions
  COMPOSITIONS_COUNT.times do |index|
    name        = Faker::Lorem.word
    description = Faker::Lorem.sentence(3, true, 4)
    position    = index + 1

    Composition.create name: name, description: description, position: position
  end
end

def make_pictures_for_compositions
  Composition.all.each do |cm|
    imageable_id   = cm.id
    imageable_type = 'Composition'
    image          = Faker::Avatar.image

    Picture.create imageable_id: imageable_id, imageable_type: imageable_type, image: image
  end
end
