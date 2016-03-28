class DatOrchestra.Routers.Pages extends Backbone.Router
  routes:
    'repertoire' : 'repertoirePage'
    '' : 'homePage'

  homePage: ->
    new DatOrchestra.Views.Home().render()

  repertoirePage: ->
    new DatOrchestra.Views.Repertoire().render()

