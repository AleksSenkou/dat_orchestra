ActiveAdmin.register Instrument do
  permit_params :name, :image

  index do
    selectable_column

    column I18n.t('active_admin.labels.title'), :name
    column(I18n.t('active_admin.labels.image')) do |i|
      image_tag i.image.url(:little), class: 'instrument-image'
    end

    actions
  end

  filter :name, label: I18n.t('active_admin.labels.title')

  show do
    attributes_table do
      row :id
      row(I18n.t('active_admin.labels.title')) { |i| i.name }
      row(I18n.t('active_admin.labels.image')) do |i|
        image_tag i.image.url(:little), class: 'instrument-image'
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
