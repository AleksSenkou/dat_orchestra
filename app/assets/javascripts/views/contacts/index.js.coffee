class DatOrchestra.Views.Contacts extends Backbone.View
  el: '#message-form'

  events:
    'ajax:beforeSend' : 'showLoader'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()
    @localeSelect = new DatOrchestra.ViewsHelpers.LocaleSelect()

  render: ->
    @base.removeHrefs()
    @createMap()

  createMap: ->
    handler = Gmaps.build('Google')
    handler.buildMap { provider: { scrollwheel: false }, internal: { id: 'map' } }, () =>
      markers = handler.addMarkers [ "lat": gon.lat, "lng": gon.lng ]
      handler.bounds.extendWith(markers)
      handler.fitMapToBounds()
      handler.getMap().setZoom(17)

  showLoader: (e) ->
    $('.ok-icon').hide()
    $('.loader').show()
