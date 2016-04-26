ActiveAdmin.register BasePage do
  menu priority: 2, url: "/admin/base_pages/#{ BasePage.first.try(:id) }"

  breadcrumb do
    root = [ link_to(I18n.t("active_admin.dashboard"), admin_root_path) ]
    if current_page?(edit_admin_base_page_path)
      root << link_to(I18n.t("activerecord.models.base_page.other"), admin_base_page_path(BasePage.first.try(:id)))
    else
      root
    end
  end

  actions :show, :update, :edit

  includes :translations

  permit_params :heading, :subheading_ru, :subheading_en, :bg_color,
    :logo, :dance_logo, :favicon, :hero_image

  show title: I18n.t("activerecord.models.base_page.one") do
    attributes_table do
      row(I18n.t('active_admin.labels.heading')) { |c| c.heading }
      row(I18n.t('active_admin.labels.subheading_ru')) { |c| c.subheading_ru }
      row(I18n.t('active_admin.labels.subheading_en')) { |c| c.subheading_en }
      row(I18n.t('active_admin.labels.bg_color')) do |c|
        div class: 'show-bg-color', style: "background-color: #{c.bg_color}" do
          span c.bg_color
        end
      end
      row(I18n.t('active_admin.labels.hero_image')) do |bp|
        image_tag bp.hero_image.url(:big), class: 'admin-hero-image'
      end
      row(I18n.t('active_admin.labels.logo')) do |bp|
        image_tag bp.logo.url(:big)
      end
      row(I18n.t('active_admin.labels.favicon')) do |bp|
        image_tag bp.favicon.url(:medium)
      end
      row(I18n.t('active_admin.labels.dance_logo')) do |bp|
        image_tag bp.dance_logo.url(:original)
      end
    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.necessary_information') do
      f.input :heading,
        label: I18n.t('active_admin.labels.heading'),
        hint: 'Заглавные буквы будут выделены жирным шрифтом'
      f.input :subheading_ru, label: I18n.t('active_admin.labels.subheading_ru')
      f.input :subheading_en, label: I18n.t('active_admin.labels.subheading_en')
      f.input :bg_color, label: I18n.t('active_admin.labels.bg_color')
      f.input :hero_image, as: :file,
        label: I18n.t('active_admin.labels.hero_image'),
        hint: f.object.hero_image.exists? ? image_tag(f.object.hero_image.url(:big), class: 'edit-admin-hero-image') : ''
      f.input :logo, as: :file,
        label: I18n.t('active_admin.labels.logo'),
        hint: bp_image(f.object.logo, 'big', 'Нужен прозрачный фон')
      f.input :favicon, as: :file,
        label: I18n.t('active_admin.labels.favicon'),
        hint: bp_image(f.object.favicon, 'medium', 'Нужен прозрачный фон')
      f.input :dance_logo, as: :file,
        label: I18n.t('active_admin.labels.dance_logo'),
        hint: bp_image(f.object.dance_logo, 'original', 'Нужен прозрачный фон')
    end

    f.actions do
      f.action :submit
      f.action :cancel, wrapper_html: { class: 'cancel' }
    end
  end


end
