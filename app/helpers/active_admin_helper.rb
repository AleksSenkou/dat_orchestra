module ActiveAdminHelper

  def document_hint(object)
    result = content_tag :span, I18n.t('active_admin.hint.document.pdf')

    object.document.exists? ? result << image_tag(object.document.url(:thumb)) : result
  end

  def default_image_hint(object, class_name)
    if object.image.exists?
      image_tag object.image.url(:little), class: class_name
    end
  end

  def bp_image(image, style, hint_text)
    result = content_tag :span, hint_text, class: 'edit-base-page-image'

    image.exists? ? result << image_tag(image.url(style.to_sym)) : result
  end

  def admin_messages_link
    label = I18n.t("activerecord.models.message.other")
    label << " (#{ Message.not_viewed.count })" if Message.not_viewed.count > 0

    result = content_tag :span, label
    Message.not_viewed.any? ? result << image_tag('unread_message.png') : result
  end

end
