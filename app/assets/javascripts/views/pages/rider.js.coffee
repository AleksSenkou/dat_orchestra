class DatOrchestra.Views.Rider extends Backbone.View
  el: 'body'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()

  render: ->
    @base.removeHrefs()
