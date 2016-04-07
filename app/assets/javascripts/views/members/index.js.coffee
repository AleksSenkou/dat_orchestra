class DatOrchestra.Views.Members extends Backbone.View
  el: 'body'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()

  render: ->
    @base.removeHrefs()
