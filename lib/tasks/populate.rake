require "faker"
require "populator"
require 'fileutils'

COMPOSITIONS_COUNT = 10
MEMBERS_COUNT = 12
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

    puts 'make_instruments'
    make_instruments

    puts 'make_contacts'
    make_contacts

    puts 'make_members'
    make_members
    puts 'make_pictures_for_members'
    make_pictures_for_members
    puts 'add_instruments_to_members'
    add_instruments_to_members

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
  [ Composition, Picture, Member, BasePage, GalleryItem, Instrument ].each(&:delete_all)
end

def clean_public_data
  [ 'images', 'music', 'gallery', 'instruments' ].each do |folder|
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

def make_instruments
  Dir[Rails.root.join('test', 'images', 'instruments', '*')].each do |image_path|
    Instrument.create image: open_file(image_path)
  end
end

def make_contacts
  contact = Contact.create!(
    email: Faker::Internet.email,
    name: Faker::Name.first_name,
    phone_number: Faker::PhoneNumber.phone_number.first(12),
    address_country: Faker::Address.country,
    address_city: Faker::Address.city,
    address_street: Faker::Address.street_address
  )

  create_picture contact.id, 'Contact', sample_avatar
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
    member.first_name  = Faker::Name.first_name
    member.surname     = Faker::Name.last_name
    member.description = Faker::Lorem.sentence(4, true, 20).first(150)
    member.position    = index + 1
  end
end

def make_pictures_for_members
  Member.ids.each do |member_id|
    create_picture member_id, 'Member', sample_avatar
  end
end

def add_instruments_to_members
  member_ids = Member.ids
  instrument_ids = Instrument.ids

  member_ids.each do |m_id|
    rand(1..6).times do
      MemberInstrument.create member_id: m_id, instrument_id: instrument_ids.sample
    end
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
    title = Faker::Lorem.word
    position = index + 1

    if rand(0..1) == 0
      GalleryItem.create title: title, position: position, image: sample_image
    else
      GalleryItem.create title: title, position: position, video_link: sample_video_link
    end
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

def sample_avatar
  gender = [ 'men', 'women' ].sample
  number = rand(1..60).to_s
  "https://randomuser.me/api/portraits/#{ gender }/#{ number }.jpg"
end

def sample_video_link
  ['https://www.youtube.com/watch?v=3tZSY6RRGlw', 'https://www.youtube.com/watch?v=TiCxqhu9cio', 'https://www.youtube.com/watch?v=IxuThNgl3YA&list=RDTiCxqhu9cio&index=4&nohtml5=False'].sample
end

def open_file(file_name); File.new(file_name); end
