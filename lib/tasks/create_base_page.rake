desc 'Create BasePage'
task create_base_page: :environment do
  make_base_page
end

def make_base_page
  BasePage.create!(
    logo: get_image('logo.png'),
    dance_logo: get_image('dance-logo.png'),
    favicon: get_image('favicon.png'),
    hero_image: get_image('hero_cuted.jpg'),
    bg_color: '#f7f7f7',
    heading: 'DAT-arkestr',
    subheading_en: 'We will make our concert unforgettable',
    subheading_ru: 'Мы сделаем наш концерт незабываемым'
  )
end

def get_image(image_name)
  open_file Rails.root.join('test', 'images', 'base_page', image_name)
end

def open_file(file_name); File.new(file_name); end
