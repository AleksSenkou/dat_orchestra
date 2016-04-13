class DatOrchestra.ViewsHelpers.LocaleSelect extends Backbone.View
  el: 'body'

  events:
    'click .locale-select > a:not(.current)' : 'changeLocale'

  render: ->
    $('.locale-select > a:not(.current)').removeAttr('href')

  changeLocale: (e) ->
    $.ajax
      url: 'set_locale'
      type: 'GET'
      data:
        locale: $(e.target).data('locale')
      complete: ->
        location.reload()
