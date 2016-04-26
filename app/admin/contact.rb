ActiveAdmin.register Contact do
  menu priority: 8, url: "/admin/contacts/#{ Contact.first.try(:id) }"

  breadcrumb do
    root = [ link_to(I18n.t("active_admin.dashboard"), admin_root_path) ]
    if current_page?(edit_admin_contact_path)
      root << link_to(I18n.t("activerecord.models.contact"), admin_contact_path(Contact.first.try(:id)))
    else
      root
    end
  end

  actions :show, :update, :edit

  includes :picture, :translations

  permit_params :name_ru, :name_en, :email, :phone_number, :address,
    picture_attributes: [:image]

  show do
    attributes_table do
      row(I18n.t('active_admin.labels.name_ru')) { |c| c.name_ru }
      row(I18n.t('active_admin.labels.name_en')) { |c| c.name_en }
      row(I18n.t('active_admin.labels.email')) { |c| c.email }
      row(I18n.t('active_admin.labels.phone_number')) { |c| c.phone_number }
      row(I18n.t('active_admin.labels.address')) { |c| c.address }
      row(I18n.t('active_admin.labels.avatar')) do |c|
        image_tag c.avatar.url(:little), class: 'avatar'
      end
    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :name_ru, label: I18n.t('active_admin.labels.name_ru')
      f.input :name_en, label: I18n.t('active_admin.labels.name_en')
      f.input :email, label: I18n.t('active_admin.labels.email')
      f.input :phone_number, label: I18n.t('active_admin.labels.phone_number')
      f.input :address, label: I18n.t('active_admin.labels.address')
      f.inputs '', for: [:picture, f.object.picture] do |pf|
        pf.input :image, as: :file,
          label: I18n.t('active_admin.labels.avatar'),
          hint: default_image_hint(pf.object, 'avatar')
      end
    end
    f.actions do
      f.action :submit
      f.action :cancel, wrapper_html: { class: 'cancel' }
    end
  end

end
