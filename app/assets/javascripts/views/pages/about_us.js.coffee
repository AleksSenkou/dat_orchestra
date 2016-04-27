class DatOrchestra.Views.AboutUs extends Backbone.View
  el: 'body'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()
    @localeSelect = new DatOrchestra.ViewsHelpers.LocaleSelect()

  render: ->
    @base.removeHrefs()
