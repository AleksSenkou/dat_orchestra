class DatOrchestra.Views.GalleryItems extends Backbone.View
  el: 'body'

  events:
    'click .filter' : 'toggleActiveFilter'

  initialize: ->
    @lightcase = new DatOrchestra.ViewsHelpers.LightCase()
    @base = new DatOrchestra.ViewsHelpers.Base()
    @searchInput = new DatOrchestra.ViewsHelpers.SearchInput()

  render: ->
    @lightcase.render(audioPlayer: false)
    @base.removeHrefs()
    @filterizr()

  filterizr: ->
    $('.filtr-container').filterizr()

  toggleActiveFilter: (e) ->
    $('.filter li').removeClass 'active'
    $(e.target).addClass 'active'

