ActiveAdmin.register Composition do
  includes :picture, :translations, members: :picture

  permit_params :title, :description, :position, :song,
    picture_params: [:image]

  config.sort_order = 'position_asc'

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
          "#{a.first_name} #{a.surname}"
        end
      end
    end

    actions
  end

  filter :title, label: I18n.t('active_admin.labels.title')
  filter :description, label: I18n.t('active_admin.labels.description')
  filter :position, label: I18n.t('active_admin.labels.position')
  filter :members, collection: proc { Member.all.map { |m| "#{m.first_name} #{m.surname}" } }

end
