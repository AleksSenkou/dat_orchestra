class DatOrchestra.Views.Repertoire extends Backbone.View
  el: 'body'

  initialize: ->
    @lightcase = new DatOrchestra.ViewsHelpers.LightCase()
    @base = new DatOrchestra.ViewsHelpers.Base()

  render: ->
    @lightcase.render(audioPlayer: true)
    @base.removeHrefs()
