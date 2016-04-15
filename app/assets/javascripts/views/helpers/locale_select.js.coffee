class DatOrchestra.ViewsHelpers.LocaleSelect extends Backbone.View
  el: 'body'

  events:
    'click .locale-select > span:not(.current)' : 'changeLocale'

  changeLocale: (e) ->
    $.ajax
      url: 'set_locale'
      type: 'GET'
      data:
        locale: $(e.target).data('locale')
      success: -> location.reload()
