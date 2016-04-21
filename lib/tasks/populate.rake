require "faker"
require "populator"
require 'fileutils'

COMPOSITIONS_COUNT = 10
MEMBERS_COUNT = 12
GALLERY_ITEMS_COUNT = 10
MESSAGES_COUNT = 8

namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # puts 'clean_database'
    # clean_database
    # puts 'clean_public_data'
    # clean_public_data

    # puts 'make_admin'
    # make_admin

    # puts 'make_base_page'
    # make_base_page

    # puts 'make_instruments'
    # make_instruments

    # puts 'make_contacts'
    # make_contacts

    # puts 'make_members'
    # make_members
    # puts 'make_pictures_for_members'
    # make_pictures_for_members
    # puts 'add_instruments_to_members'
    # add_instruments_to_members

    # puts 'make_compositions'
    # make_compositions
    # puts 'make_pictures_for_compositions'
    # make_pictures_for_compositions
    # puts 'add_members_to_compositions'
    # add_members_to_compositions

    # puts 'make_gallery_items'
    # make_gallery_items

    # puts 'make_riders'
    # make_riders

    puts 'make_messages'
    make_messages
  end
end

def clean_database
  Rake::Task['db:reset'].invoke
end

def clean_public_data
  [ 'images', 'music', 'gallery', 'instruments', 'riders' ].each do |folder|
    FileUtils.rm_rf 'public/' + folder
  end
end

def make_admin
  AdminUser.create!(
    email: 'dat@arkestr.net',
    password: 'password',
    password_confirmation: 'password'
  )
end

def make_base_page
  BasePage.create!(
    logo: get_image('logo.png'),
    dance_logo: get_image('dance-logo.png'),
    favicon: get_image('favicon.png'),
    hero_image: get_image('hero.jpg'),
    heading: 'DAT-arkestr',
    subheading_en: 'We will make your concert unforgettable',
    subheading_ru: 'Мы сделаем ваш концерт незабываемым'
  )
end

def make_instruments
  Dir[Rails.root.join('test', 'images', 'instruments', '*')].each do |image_path|
    Instrument.create image: open_file(image_path)
  end

  Instrument.all.map { |i| i.update_attribute :name, i.image_file_name[0..-5] }
end

def make_riders
  [
    [ 'sound_rus.pdf', 'Звуковой райдер' ],
    [ 'sound_eng.pdf', 'Sound rider' ]
  ].each do |rider_info|
    doc_path = Rails.root.join('test', 'documents', rider_info[0])
    Rider.create title: rider_info[1], document: open_file(doc_path)
  end
end

def make_messages
  Message.populate MESSAGES_COUNT do |msg|
    msg.name = Faker::Name.name
    msg.email = Faker::Internet.email
    msg.message = Faker::Lorem.sentence(3, true, 4)
    msg.viewed = [ true, false ].sample
  end
end

def make_contacts
  Contact.new(
    email: Faker::Internet.email,
    name_en: 'Andrew',
    name_ru: 'Андрей',
    phone_number: Faker::PhoneNumber.phone_number,
    address: 'Минск, проспект независимости, 50'
  ).save!(validate: false)

  create_picture Contact.first.id, 'Contact', sample_avatar
end

def make_compositions
  COMPOSITIONS_COUNT.times do |index|
    cm = Composition.new

    cm.title_en       = Faker::Lorem.word
    cm.description_en = Faker::Lorem.sentence(3, true, 4)

    cm.title_ru       = ['полька', 'рок', 'альтернативный рок', 'джаз', 'импровизация'].sample
    cm.description_ru = Faker::Lorem.sentence(3, true, 4)

    cm.position       = index + 1

    cm.song           = sample_song

    cm.save!
  end
end

def make_pictures_for_compositions
  Composition.ids.each do |cm_id|
    create_picture cm_id, 'Composition', sample_image
  end
end

def make_members
  MEMBERS_COUNT.times do |index|
    Member.new(
      first_name_en:  Faker::Name.first_name,
      surname_en:     Faker::Name.last_name,
      description_en: Faker::Lorem.sentence(4, true, 20).first(140),

      first_name_ru:  ['саша', 'паша', 'ваня', 'женя'].sample,
      surname_ru:     ['котельников', 'павлов', 'домок', 'пеньков'].sample,
      description_ru: Faker::Lorem.sentence(4, true, 20).first(140),

      position: index + 1
    ).save!(validate: false)
  end
end

def make_pictures_for_members
  Member.ids.each do |member_id|
    create_picture member_id, 'Member', sample_avatar
  end
end

def add_instruments_to_members
  member_ids = Member.ids

  member_ids.each do |m_id|
    Instrument.ids.sample(rand(1..6)).each do |instrument_id|
      MemberInstrument.create member_id: m_id, instrument_id: instrument_id
    end
  end
end

def add_members_to_compositions
  composition_ids = Composition.ids

  composition_ids.each do |cm_id|
    Member.ids.sample(rand(1..MEMBERS_COUNT / 2)).each do |member_id|
      CompositionsMembers.create composition_id: cm_id, member_id: member_id
    end
  end
end

def make_gallery_items
  GALLERY_ITEMS_COUNT.times do |index|
    title_en = Faker::Lorem.word
    title_ru = ['полька', 'рок', 'альтернативный рок', 'джаз', 'импровизация'].sample
    position = index + 1

    if rand(0..1) == 0
      GalleryItem.create title_en: title_en, title_ru: title_ru, position: position, image: sample_image
    else
      GalleryItem.create title_en: title_en, title_ru: title_ru, position: position, video_link: sample_video_link
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
