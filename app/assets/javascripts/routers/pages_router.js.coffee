class DatOrchestra.Routers.Pages extends Backbone.Router
  routes:
    'repertoire' : 'repertoirePage'
    'repertoire/' : 'repertoirePage'
    'gallery': 'galleryItems'
    'gallery/': 'galleryItems'
    'members': 'membersIndex'
    'members/': 'membersIndex'
    '' : 'homePage'

  homePage: ->
    new DatOrchestra.Views.Home().render()

  repertoirePage: ->
    new DatOrchestra.Views.Repertoire().render()

  galleryItems: ->
    new DatOrchestra.Views.GalleryItems().render()

  membersIndex: ->
    new DatOrchestra.Views.Members().render()
