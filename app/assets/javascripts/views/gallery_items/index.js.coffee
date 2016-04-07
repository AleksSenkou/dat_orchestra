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
    _.delay @switchActiveElements, 500, e, @

  switchActiveElements: (e, view) ->
    switch $(e.target).data('filter')
      when 1 then view.deactivate(2) and view.activate(1)
      when 2 then view.deactivate(1) and view.activate(2)
      when 'all' then view.activate('all')
    view.lightcase.render(audioPlayer: false)

  activate: (filter) ->
    $(".filtr-item[data-category='#{ filter }'] > .gallery-play").attr 'data-rel', 'lightcase:myCollection'

  deactivate: (filter) ->
    $(".filtr-item[data-category='#{ filter }']").css 'display', 'none'
    $(".filtr-item[data-category='#{ filter }'] > .gallery-play").attr 'data-rel', ''
