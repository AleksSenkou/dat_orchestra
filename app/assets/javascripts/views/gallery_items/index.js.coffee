class DatOrchestra.Views.GalleryItems extends Backbone.View
  el: 'body'

  events:
    'click .filter' : 'toggleActiveFilter'

  initialize: ->
    @lightcase = new DatOrchestra.ViewsHelpers.LightCase()
    @base = new DatOrchestra.ViewsHelpers.Base()
    @searchInput = new DatOrchestra.ViewsHelpers.SearchInput()
    @searchInput.on 'close', () => @restartFilterizr()

  render: ->
    @lightcase.render(audioPlayer: false)
    @base.removeHrefs()
    @filterizr 'all'

  restartFilterizr: ->
    filterMode = $('.filter li.active').data('filter')
    @filterizr filterMode

  filterizr: (filterMode) ->
    $('.filtr-container').filterizr(
      filter: filterMode
    )

  toggleActiveFilter: (e) ->
    $('.filter li').removeClass 'active'
    $(e.target).addClass 'active'
