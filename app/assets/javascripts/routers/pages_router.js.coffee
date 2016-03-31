class DatOrchestra.Routers.Pages extends Backbone.Router
  routes:
    'repertoire' : 'repertoirePage'
    'gallery_items': 'galleryItems'
    '' : 'homePage'

  homePage: ->
    new DatOrchestra.Views.Home().render()

  repertoirePage: ->
    new DatOrchestra.Views.Repertoire().render()

  galleryItems: ->
    new DatOrchestra.Views.GalleryItems().render()
