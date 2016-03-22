class DatOrchestra.Views.Home extends Backbone.View
  el: 'body'
  fadeHeight: 200

  events:
    'click #goto-main-section' : 'goToMainSection'

  initialize: ->
    @fadeUntil = $('.hero-heading').position().top

    $(window).bind 'scroll', () => @changeHeaderTextOpacity()

  render: -> @addComposirionsGallery()

  addComposirionsGallery: ->
    $('a[data-rel^=lightcase]').lightcase
      forceWidth: true
      forceHeight: true
      overlayOpacity: 0.95
      transitionIn: 'elastic'
      transition: 'scrollHorizontal'
      onClose: finish: () => @stopPlay()

  stopPlay: ->
    $.each $('audio'), () ->
      @pause()
      @currentTime = 0

  goToMainSection: ->
    $('html, body').animate {
      scrollTop: $(".main-section").offset().top
    }, 800

  changeHeaderTextOpacity: ->
    offset = $(document).scrollTop()
    opacity = (@fadeUntil - offset) / @fadeHeight
    $('.hero-heading, .hero-subheading, #goto-main-section').css 'opacity', opacity
