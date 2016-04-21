ActiveAdmin.register Rider do
  menu priority: 5

  permit_params :title, :document

  index do
    selectable_column
    column I18n.t('active_admin.labels.title'),              :title
    column I18n.t('active_admin.labels.document_file_name'), :document_file_name
    column(I18n.t('active_admin.labels.preview')) do |rider|
      link_to image_tag(rider.document.url(:thumb)), rider.document.url(:original), class:'rider-preview'
    end
    actions
  end

  filter :title, label: I18n.t('active_admin.labels.title')
  filter :document_file_name, label: I18n.t('active_admin.labels.document_file_name')

  show do
    attributes_table do
      row :id
      row(I18n.t('active_admin.labels.title')) { |rider| rider.title }
      row(I18n.t('active_admin.labels.document_file_name')) do |rider|
        rider.document_file_name
      end
      row(I18n.t('active_admin.labels.preview')) do |rider|
        link_to image_tag(rider.document.url(:thumb)), rider.document.url(:original), class:'rider-preview'
      end
    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :title, hint: I18n.t('active_admin.hint.rider.title'), label: I18n.t('active_admin.labels.title')
      f.input :document, as: :file, label: I18n.t('active_admin.labels.document'), hint: document_hint(f.object)
    end
    f.actions
  end

end
