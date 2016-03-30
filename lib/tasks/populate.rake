require "faker"
require "populator"
require 'fileutils'

COMPOSITIONS_COUNT = 16
MEMBERS_COUNT = 10
GALLERY_ITEMS_COUNT = 10

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    puts 'clean_database'
    clean_database
    puts 'clean_public_data'
    clean_public_data

    puts 'make_base_page'
    make_base_page

    puts 'make_members'
    make_members
    puts 'make_pictures_for_members'
    make_pictures_for_members

    puts 'make_compositions'
    make_compositions
    puts 'make_pictures_for_compositions'
    make_pictures_for_compositions
    puts 'add_members_to_compositions'
    add_members_to_compositions

    puts 'make_gallery_items'
    make_gallery_items
  end
end

def clean_database
  [ Composition, Picture, Member, BasePage, GalleryItem ].each(&:delete_all)
end

def clean_public_data
  [ 'images', 'music', 'gallery_items' ].each do |folder|
    FileUtils.rm_rf 'public/' + folder
  end
end

def make_base_page
  BasePage.create!(
    logo: get_image('logo.png'),
    dance_logo: get_image('dance-logo.png'),
    favicon: get_image('favicon.png'),
    hero_image: get_image('hero.jpg'),
    heading: 'DAT-arkestr',
    subheading: 'We will make your concert savemem'
  )
end

def make_compositions
  Composition.populate COMPOSITIONS_COUNT do |cm, index|
    cm.title       = Faker::Lorem.word
    cm.description = Faker::Lorem.sentence(3, true, 4)
    cm.position    = index + 1
  end

  Composition.all.each { |cm| cm.song = sample_song; cm.save! }
end

def make_pictures_for_compositions
  Composition.ids.each do |cm_id|
    create_picture cm_id, 'Composition', sample_image
  end
end

def make_members
  Member.populate MEMBERS_COUNT do |member, index|
    member.name        = Faker::Name.name
    member.description = Faker::Lorem.sentence(4, true, 20)
    member.position    = index + 1
  end
end

def make_pictures_for_members
  Member.ids.each do |member_id|
    create_picture member_id, 'Member', Faker::Avatar.image
  end
end

def add_members_to_compositions
  composition_ids = Composition.ids
  member_ids = Member.ids

  composition_ids.each do |cm_id|
    rand(1..MEMBERS_COUNT / 2).times do
      CompositionsMembers.create composition_id: cm_id, member_id: member_ids.sample
   end
 end
end

def make_gallery_items
  GALLERY_ITEMS_COUNT.times do |index|
    name  = Faker::Lorem.word
    source = [ method(:sample_image), method(:sample_video) ].sample.call
    position = index + 1

    GalleryItem.create name: name, source: source, position: position
  end
end

def create_picture(imageable_id, imageable_type, image)
  Picture.create(
    imageable_id: imageable_id,
    imageable_type: imageable_type,
    image: image
  )
end

def get_image(image_name)
  open_file Rails.root.join('test', 'images', 'base_page', image_name)
end

def sample_image
  open_file Dir[Rails.root.join('test', 'images', 'concert', '*')].sample
end

def sample_song
  open_file Dir[Rails.root.join('test', 'music', '*')].sample
end

def sample_video
  open_file Dir[Rails.root.join('test', 'video', '*')].sample
end

def open_file(file_name); File.new(file_name); end
