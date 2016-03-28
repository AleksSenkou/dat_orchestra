#= require_self
#= require_tree ./views
#= require_tree ./routers

window.DatOrchestra =
  Models: {}
  Collections: {}
  Views: {}
  ViewsHelpers: {}
  Routers: {}
  initialize: ->
    new DatOrchestra.Routers.Pages()
    Backbone.history.start(
      pushState: true
      hashChange: false
      root: '/'
    )

$(document).ready -> DatOrchestra.initialize()
