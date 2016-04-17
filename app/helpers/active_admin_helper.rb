module ActiveAdminHelper

  def document_hint(object)
    result = content_tag :span, I18n.t('active_admin.hint.document.pdf')

    object.document.exists? ? result << image_tag(object.document.url(:thumb)) : result
  end

end
