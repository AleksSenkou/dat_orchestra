ActiveAdmin.register AdminUser do
  menu priority: 9

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    column I18n.t('active_admin.labels.email'),         :email
    column I18n.t('active_admin.labels.sign_in_count'), :sign_in_count
    column I18n.t('active_admin.labels.created_at'),    :created_at
    actions
  end

  filter :email, label: I18n.t('active_admin.labels.email')
  filter :sign_in_count, label: I18n.t('active_admin.labels.sign_in_count')
  filter :created_at, label: I18n.t('active_admin.labels.created_at')

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :email, label: I18n.t('active_admin.labels.email')
      f.input :password, label: I18n.t('active_admin.labels.password')
      f.input :password_confirmation, label: I18n.t('active_admin.labels.password_confirmation')
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row(I18n.t('active_admin.labels.email')) { |b| b.email }
      row(I18n.t('active_admin.labels.sign_in_count')) { |b| b.sign_in_count }
      row(I18n.t('active_admin.labels.last_sign_in_at')) { |b| b.last_sign_in_at }
      row(I18n.t('active_admin.labels.created_at')) { |b| b.created_at }
      row(I18n.t('active_admin.labels.updated_at')) { |b| b.updated_at }
    end
  end

end
