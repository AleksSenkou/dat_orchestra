ActiveAdmin.register Composition do
  config.sort_order = 'position_asc'

  includes :picture, :translations, members: :translations

  permit_params :title_ru, :title_en,
    :description_ru, :description_en,
    :position, :song,
    picture_params: [:image]

  index do
    selectable_column

    column I18n.t('active_admin.labels.position'), :position
    column(I18n.t('active_admin.labels.image')) { |i| image_tag(i.image.url(:little)) }
    column I18n.t('active_admin.labels.title'),          :title
    column I18n.t('active_admin.labels.description'),    :description
    column I18n.t('active_admin.labels.song_file_name'), :song_file_name

    column I18n.t('active_admin.labels.members') do |cm|
      cm.authors.each do |a|
        div class: 'member-name' do
          link_to "#{a.first_name} #{a.surname}", admin_member_path(a)
        end
      end
    end

    actions
  end

  filter :title, label: I18n.t('active_admin.labels.title')
  filter :description, label: I18n.t('active_admin.labels.description')
  filter :position, label: I18n.t('active_admin.labels.position')
  filter :members, collection: proc { Member.for_select }

end
