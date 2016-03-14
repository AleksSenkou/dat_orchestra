#= require_self
#= require_tree ./views
#= require_tree ./routers

window.DatOrchestra =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new DatOrchestra.Routers.Pages()
    Backbone.history.start()

$(document).ready -> DatOrchestra.initialize()
