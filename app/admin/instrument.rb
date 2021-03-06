ActiveAdmin.register Instrument do
  menu priority: 7

  permit_params :name, :image

  includes members: :translations

  index do
    selectable_column

    column I18n.t('active_admin.labels.title'), :name
    column(I18n.t('active_admin.labels.image')) do |i|
      image_tag i.image.url(:little), class: 'instrument-image'
    end
    column(I18n.t('active_admin.labels.musicians')) do |i|
      i.members.each do |m|
        div class: 'instruments-member-name' do
          link_to m.full_name, admin_member_path(m.id)
        end
      end
    end

    actions
  end

  filter :name, label: I18n.t('active_admin.labels.title')
  filter :members, as: :select,
    collection: proc { Member.for_select },
    label: I18n.t('active_admin.labels.musicians')

  show do
    attributes_table do
      row :id
      row(I18n.t('active_admin.labels.title')) { |i| i.name }
      row(I18n.t('active_admin.labels.image')) do |i|
        image_tag i.image.url(:little), class: 'instrument-image'
      end
      row(I18n.t('active_admin.labels.musicians')) do |i|
        if i.members.present?
          i.members.each do |m|
            div class: 'instruments-member-name' do
              link_to m.full_name, admin_member_path(m.id)
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
      f.input :name,
        label: I18n.t('active_admin.labels.title'),
        hint: I18n.t('active_admin.hint.instrument.name')
      f.input :image, as: :file,
        label: I18n.t('active_admin.labels.image'),
        hint: default_image_hint(f.object, 'instrument-image')
    end
    f.actions
  end

end
