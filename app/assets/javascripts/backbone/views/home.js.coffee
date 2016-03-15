class DatOrchestra.Views.Home extends Backbone.View
  initialize: ->
    $("body").mCustomScrollbar {
      theme: 'minimal'
      scrollbarPosition: "outside"
      mouseWheelPixels: 100
    }

  render: ->
