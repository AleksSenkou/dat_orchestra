class DatOrchestra.ViewsHelpers.SearchInput extends Backbone.View
  el: '.search-box'
  active: 'active'

  events:
    'click .search-icon:not(.active)' : 'openSearchInput'
    'click .search-icon.active' : 'closeSearchInput'

  initialize: ->
    @icon = $('.search-icon')
    @searchInput = $('.filtr-search')

  closeSearchInput: ->
    _.each [ @icon, @searchInput ], (tag) => tag.removeClass @active
    @searchInput.val ''
    @searchInput.css('padding-left', '0px')
    @trigger 'close'

  openSearchInput: ->
    _.each [ @icon, @searchInput ], (tag) => tag.addClass @active
    @searchInput.focus()
    @searchInput.val '   '
    @searchInput.delay(200).queue (next) ->
      $(this).css('padding-left', '9px')
      $(this).val ''
      next()
