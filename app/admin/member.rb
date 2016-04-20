ActiveAdmin.register Member do
  config.sort_order = 'position_asc'

  includes :picture, :instruments, :translations, compositions: :translations

  permit_params :position,
    :first_name_ru, :first_name_en,
    :surname_ru, :surname_en,
    :description_ru, :description_en,
    picture_attributes: [:image]

  index do
    selectable_column

    column I18n.t('active_admin.labels.position'), :position
    column(I18n.t('active_admin.labels.avatar')) do |m|
      image_tag(m.avatar.url(:little), class:'avatar') if m.picture.present?
    end
    column I18n.t('active_admin.labels.name'), :first_name
    column I18n.t('active_admin.labels.surname'), :surname
    column I18n.t('active_admin.labels.description'), :description
    column I18n.t('active_admin.labels.compositions') do |member|
      member.compositions.each do |cm|
        div class: 'member-composition' do
          link_to cm.title, admin_composition_path(cm.id)
        end
      end
    end
    column(I18n.t('active_admin.labels.instruments')) do |member|
      member.instruments.each_slice(2) do |instruments|
        div class: 'member-instruments' do
          instruments.each do |i|
            div class: 'member-instrument' do
              link_to image_tag(i.image.url(:little)), admin_instrument_path(i.id)
            end
          end
        end
      end
    end

    actions
  end

  filter :first_name, label: I18n.t('active_admin.labels.name')
  filter :surname, label: I18n.t('active_admin.labels.surname')
  filter :description, label: I18n.t('active_admin.labels.description')
  filter :position, label: I18n.t('active_admin.labels.position')
  filter :compositions, as: :select,
    collection: proc { Composition.includes(:translations).all },
    label: I18n.t('active_admin.labels.compositions')
  filter :instruments, label: I18n.t('active_admin.labels.instruments')

  show do
    attributes_table do
      row(I18n.t('active_admin.labels.position')) { |m| m.position }

      row(I18n.t('active_admin.labels.avatar')) do |m|
        image_tag m.avatar.url(:little), class:'avatar'
      end

      row(I18n.t('active_admin.labels.name')) { |m| m.first_name }
      row(I18n.t('active_admin.labels.surname')) { |m| m.surname }
      row(I18n.t('active_admin.labels.description')) { |m| m.description }

      row(I18n.t('active_admin.labels.compositions')) do |member|
        if member.compositions.present?
          member.compositions.includes(:translations).each do |cm|
            div class: 'show-member-composition' do
              link_to cm.title, admin_composition_path(cm.id)
            end
          end
        else
          span class: 'empty' do
            I18n.t('active_admin.empty')
          end
        end
      end

      row(I18n.t('active_admin.labels.instruments')) do |member|
        member.instruments.each_slice(2) do |instruments|
          div class: 'member-instruments' do
            instruments.each do |i|
              div class: 'member-instrument' do
                link_to image_tag(i.image.url(:little)), admin_instrument_path(i.id)
              end
            end
          end
        end
      end

    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :position, label: I18n.t('active_admin.labels.position'),
        input_html: { value: f.object.position || Member.last.position + 1 }
      f.input :first_name_ru, label: I18n.t('active_admin.labels.name_ru')
      f.input :first_name_en, label: I18n.t('active_admin.labels.name_en')
      f.input :surname_ru, label: I18n.t('active_admin.labels.surname_ru')
      f.input :surname_en, label: I18n.t('active_admin.labels.surname_en')
      f.input :description_ru, as: :text,
        label: I18n.t('active_admin.labels.description_ru')
      f.input :description_en, as: :text,
        label: I18n.t('active_admin.labels.description_en')
      f.inputs '', for: [:picture, f.object.picture || Picture.new ] do |pf|
        pf.input :image, as: :file,
          label: I18n.t('active_admin.labels.avatar'),
          hint: default_image_hint(pf.object, 'avatar')
      end
    end

    f.inputs I18n.t('active_admin.labels.compositions') do
      if f.object.compositions.present?
        f.object.compositions.includes(:translations).each do |cm|
          div class: 'show-member-composition' do
            link_to cm.title, admin_composition_path(cm.id)
          end
        end
      else
        span class: 'empty' do
          I18n.t('active_admin.empty')
        end
      end
    end

    f.actions
  end

end
