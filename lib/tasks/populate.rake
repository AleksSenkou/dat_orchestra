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
    add_songs_to_compositions
  end
end

def clean_database
  [Composition, Picture, Member, CompositionsMembers].each(&:delete_all)
end

def make_compositions
  COMPOSITIONS_COUNT.times do |index|
    title       = Faker::Lorem.word
    description = Faker::Lorem.sentence(3, true, 4)
    position    = index + 1

    Composition.create title: title, description: description, position: position
  end
end

def make_pictures_for_compositions
  Composition.all.each do |cm|
    imageable_id   = cm.id
    imageable_type = 'Composition'
    image          = sample_image

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
  composition_ids = Composition.ids
  member_ids = Member.ids

  composition_ids.each do |cm_id|
    rand(1..MEMBERS_COUNT / 2).times do
      CompositionsMembers.create composition_id: cm_id, member_id: member_ids.sample
    end
  end
end

def add_songs_to_compositions
  Composition.all.each do |cm|
    cm.song = sample_song

    cm.save!
  end
end

def sample_image
  image_name = ['first.jpg', 'second.jpg', 'third.jpg', 'fourth.jpg'].sample

  path = Rails.root.join('app', 'assets', 'images', image_name)

  File.new(path)
end

def sample_song
  song_name = ['joe_pug.mp3', 'little_boxes.mp3', 'love_is_all_i_am.mp3', 'neil_young_heart_of_gold.mp3'].sample

  path = Rails.root.join('app', 'assets', 'music', song_name)

  File.new(path)
end
