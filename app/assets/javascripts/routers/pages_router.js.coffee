class DatOrchestra.Routers.Pages extends Backbone.Router
  routes:
    '' : 'homePage'

  homePage: ->
    view = DatOrchestra.Views.Home
    new view().render()
