class DatOrchestra.Views.Contacts extends Backbone.View
  el: '#message-form'

  events:
    'ajax:beforeSend' : 'showLoader'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()

  render: ->
    @base.removeHrefs()

  showLoader: (e) ->
    $('.ok-icon').hide()
    $('.loader').show()
