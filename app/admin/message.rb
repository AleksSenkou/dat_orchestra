ActiveAdmin.register Message do
  menu priority: 10

  config.sort_order = 'created_at_desc'

  actions :index, :show, :destroy

  controller do
    def show
      Message.find(params[:id]).update_attribute(:viewed, true)
    end
  end

  index do
    selectable_column

    column I18n.t('active_admin.labels.name'), :name
    column I18n.t('active_admin.labels.email'), :email
    column I18n.t('active_admin.labels.message'), :message
    column I18n.t('active_admin.labels.viewed'), :viewed
    column I18n.t('active_admin.labels.send_time'), :created_at

    actions
  end

  filter :name, label: I18n.t('active_admin.labels.name')
  filter :email, label: I18n.t('active_admin.labels.email')
  filter :message, label: I18n.t('active_admin.labels.message')
  filter :created_at, label: I18n.t('active_admin.labels.send_time')
  filter :viewed, label: I18n.t('active_admin.labels.viewed')

  show do
    attributes_table do
      row :id
      row(I18n.t('active_admin.labels.name')) { |item| item.name }
      row(I18n.t('active_admin.labels.email')) { |item| item.email }
      row(I18n.t('active_admin.labels.message')) { |item| item.message }
      row(I18n.t('active_admin.labels.send_time')) { |item| item.created_at }
    end
  end
end
