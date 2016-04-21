ActiveAdmin.register Composition do
  menu priority: 3

  config.sort_order = 'position_asc'

  includes :picture, :translations, members: :translations

  permit_params :title_ru, :title_en,
    :description_ru, :description_en,
    :position, :song,
    picture_params: [:image]

  index do
    selectable_column

    column I18n.t('active_admin.labels.position'), :position
    column(I18n.t('active_admin.labels.image')) { |cm| image_tag(cm.image.url(:little)) }
    column I18n.t('active_admin.labels.title'),          :title
    column I18n.t('active_admin.labels.description'),    :description
    column I18n.t('active_admin.labels.song_file_name'), :song_file_name

    column I18n.t('active_admin.labels.members') do |cm|
      cm.authors.each do |a|
        div class: 'member-name' do
          link_to a.full_name, admin_member_path(a)
        end
      end
    end

    actions
  end

  filter :title, label: I18n.t('active_admin.labels.title')
  filter :description, label: I18n.t('active_admin.labels.description')
  filter :position, label: I18n.t('active_admin.labels.position')
  filter :members, collection: proc { Member.for_select }

  show do
    attributes_table do
      row(I18n.t('active_admin.labels.position')) { |cm| cm.position }
      row(I18n.t('active_admin.labels.image')) { |cm| image_tag(cm.image.url(:little)) }
      row(I18n.t('active_admin.labels.title_ru')) { |cm| cm.title_ru }
      row(I18n.t('active_admin.labels.title_en')) { |cm| cm.title_en }
      row(I18n.t('active_admin.labels.description_ru')) { |cm| cm.description_ru }
      row(I18n.t('active_admin.labels.description_en')) { |cm| cm.description_en }
      row(I18n.t('active_admin.labels.song_file_name')) { |cm| cm.song_file_name }

      row(I18n.t('active_admin.labels.members')) do |cm|
        if cm.authors.present?
          cm.authors.includes(:translations).each do |a|
            div class: 'show-composition-member-name' do
              link_to a.full_name, admin_member_path(a)
            end
          end
        else
          span class: 'empty' do
            I18n.t('active_admin.empty')
          end
        end
      end

    end
  end


  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :position, label: I18n.t('active_admin.labels.position'),
        input_html: { value: f.object.position || f.object.position_was || Composition.last.position + 1 }
      f.input :title_ru, label: I18n.t('active_admin.labels.title_ru')
      f.input :title_en, label: I18n.t('active_admin.labels.title_en')
      f.input :description_ru, as: :text,
        label: I18n.t('active_admin.labels.description_ru')
      f.input :description_en, as: :text,
        label: I18n.t('active_admin.labels.description_en')
      f.input :song, as: :file,
        label: I18n.t('active_admin.labels.song_file_name'),
        hint: f.object.song_file_name if f.object.song.exists?
      f.inputs '', for: [:picture, f.object.picture || Picture.new ] do |pf|
        pf.input :image, as: :file,
          label: I18n.t('active_admin.labels.avatar'),
          hint: default_image_hint(pf.object, 'avatar')
      end
    end

    f.actions

    f.inputs I18n.t('active_admin.labels.members') do
      if f.object.authors.present?
        f.object.authors.includes(:translations).each do |a|
          div class: 'edit-composition-member' do
            link_to(a.full_name, admin_member_path(a)) +
            image_tag('delete.png', title: 'убрать', data: { member_id: a.id, composition_id: f.object.id })
          end
        end
      end

      div class: 'add-composition-member-label' do
        span(I18n.t('active_admin.compositions.add_member'))
      end

      div class: 'add-member-composition' do
        select_tag("add-member", options_from_collection_for_select(Member.includes(:translations).all - f.object.authors, "id", "full_name"), prompt: "Выбрать участника:", data: { composition_id: f.object.id })
      end
    end
  end

end
