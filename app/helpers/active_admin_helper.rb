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

end
