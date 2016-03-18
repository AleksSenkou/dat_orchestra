require "faker"
require "populator"

COMPOSITIONS_COUNT = 10
MEMBERS_COUNT = 10

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    clean_database
    make_compositions
    make_pictures_for_compositions
    make_members
    make_pictures_for_members
    add_members_for_compositions
  end
end

def clean_database
  [Composition, Picture, Member, CompositionsMembers].each(&:delete_all)
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

def make_members
  MEMBERS_COUNT.times do |index|
    name        = Faker::Name.name
    description = Faker::Lorem.sentence(4, true, 20)
    position    = index + 1

    Member.create name: name, description: description, position: position
  end
end

def make_pictures_for_members
  Member.all.each do |member|
    imageable_id   = member.id
    imageable_type = 'Member'
    image          = Faker::Avatar.image

    Picture.create imageable_id: imageable_id, imageable_type: imageable_type, image: image
  end
end

def add_members_for_compositions
  Composition.all.each do |cm|
    authors = Member.all.sample(rand(1..MEMBERS_COUNT / 2))

    cm.authors << authors
  end
end
