desc 'Create BasePage'
task create_base_page: :environment do
  make_base_page
end

def make_base_page
  I18n.locale = :en
  BasePage.create!(
    logo: get_image('logo.png'),
    dance_logo: get_image('dance-logo.png'),
    favicon: get_image('favicon.png'),
    hero_image: get_image('hero.jpg'),
    heading: 'DAT-arkestr',
    subheading: 'We will make your concert unforgettable'
  )

  I18n.locale = :ru
  BasePage.first.update_attribute :subheading, 'Мы сделаем ваш концерт незабываемым'
end

def get_image(image_name)
  open_file Rails.root.join('test', 'images', 'base_page', image_name)
end

def open_file(file_name); File.new(file_name); end
