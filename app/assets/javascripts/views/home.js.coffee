class DatOrchestra.Views.Home extends Backbone.View
  el: 'body'
  fadeHeight: 200

  events:
    'click #goto-main-section' : 'goToMainSection'

  initialize: ->
    @fadeUntil = $('.hero-heading').position().top

    $(window).bind 'scroll', () => @changeHeaderTextOpacity()

  render: ->
    $('a[data-rel^=lightcase]').lightcase(
      forceWidth: true
      forceHeight: true
      overlayOpacity: 0.95
      onStart: {
        start: () =>
      }
    )

    # $("body").mCustomScrollbar {
    #   theme: 'minimal'
    #   scrollbarPosition: "outside"
    #   mouseWheelPixels: 50
    # }

  goToMainSection: ->
    $('html, body').animate {
      scrollTop: $(".main-section").offset().top
    }, 800

  changeHeaderTextOpacity: ->
    offset = $(document).scrollTop()
    opacity = (@fadeUntil - offset) / @fadeHeight
    $('.hero-heading, .hero-subheading, #goto-main-section').css 'opacity', opacity
