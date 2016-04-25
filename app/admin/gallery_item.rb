ActiveAdmin.register GalleryItem do
  menu priority: 4

  config.sort_order = 'position_asc'

  includes :translations

  permit_params :title_ru, :title_en,
    :image, :video_link,
    :position

  index do
    selectable_column

    column I18n.t('active_admin.labels.position'), :position
    column(I18n.t('active_admin.labels.resource')) do |item|
      image_tag item.thumbnail, class: 'resource-thumbnail'
    end
    column I18n.t('active_admin.labels.title'), :title
    column(I18n.t('active_admin.labels.resource_file')) { |item| item.resource_file }

    actions
  end

  filter :type_in, as: :select,
    collection: [I18n.t('active_admin.labels.photo'), I18n.t('active_admin.labels.video')],
    label: I18n.t('active_admin.labels.type')
  filter :title, label: I18n.t('active_admin.labels.title')
  filter :position, label: I18n.t('active_admin.labels.position')
  filter :video_link, label: I18n.t('active_admin.labels.video_link')
  filter :image_file_name, label: I18n.t('active_admin.labels.image_file_name')

  show do
    attributes_table do
      row(I18n.t('active_admin.labels.position')) { |item| item.position }
      row(I18n.t('active_admin.labels.type')) { |item| item.type }
      row(I18n.t('active_admin.labels.title_ru')) { |item| item.title_ru }
      row(I18n.t('active_admin.labels.title_en')) { |item| item.title_en }
      row(I18n.t('active_admin.labels.resource')) do |item|
        if item.is_image?
          image_tag item.image.url(:large)
        else
          link_to image_tag(item.video_thumbnail), item.video_link, target: :_blank
        end
      end
      row(I18n.t('active_admin.labels.resource_file')) { |item| item.resource_file }
    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :position, label: I18n.t('active_admin.labels.position'),
        input_html: { value: f.object.position || f.object.position_was || GalleryItem.last.position + 1 }
      f.input :title_ru,
        label: I18n.t('active_admin.labels.title_ru'),
        hint: 'Необязательное поле'
      f.input :title_en,
        label: I18n.t('active_admin.labels.title_en'),
        hint: 'Необязательное поле'

      if f.object.is_image?
        f.input :image, as: :file,
          label: I18n.t('active_admin.labels.photo'),
          hint: f.object.has_image? ? image_tag(f.object.image.url(:medium)) : 'Поддерживает картинки всех форматов'
      elsif f.object.is_video?
        f.input :video_link,
          label: I18n.t('active_admin.labels.video_link_from_youtube'),
          hint: f.object.has_valid_video? ? image_tag(f.object.video_thumbnail) : 'Добавьте ссылку на видео(например: https://www.youtube.com/watch?v=Qok9Ialei4c)'
      else
        div id: "resource-tabs", is_video: f.object.has_video? do
          tabs do
            tab 'PHOTO' do
              f.inputs 'Добавление фотографии' do
                f.input :image, as: :file,
                  label: I18n.t('active_admin.labels.photo'),
                  hint: 'Поддерживает картинки всех форматов'
              end
            end
            tab 'VIDEO' do
              f.inputs 'Добавление видео' do
                f.input :video_link,
                  label: I18n.t('active_admin.labels.video_link_from_youtube'),
                  hint: 'Добавьте ссылку на видео(например: https://www.youtube.com/watch?v=Qok9Ialei4c)'
              end
            end
          end
        end
      end
    end

    f.actions
  end

end
