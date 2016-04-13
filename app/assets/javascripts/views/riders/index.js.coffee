class DatOrchestra.Views.Riders extends Backbone.View
  el: 'body'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()
    @localeSelect = new DatOrchestra.ViewsHelpers.LocaleSelect()

  render: ->
    @base.removeHrefs()
    @localeSelect.render()
