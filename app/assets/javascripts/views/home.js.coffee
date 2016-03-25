class DatOrchestra.Views.Home extends Backbone.View
  el: 'body'
  fadeHeight: 200

  events:
    'click #goto-main-section' : 'goToMainSection'

  initialize: ->
    @fadeUntil = $('.hero-heading').position().top
    $(window).bind 'scroll', () => @changeHeaderTextOpacity()

  render: ->
    @addComposirionsGallery()
    @removeHref()

  addComposirionsGallery: ->
    $('a[data-rel^=lightcase]').lightcase
      forceWidth: true
      forceHeight: true
      overlayOpacity: 0.95
      showSequenceInfo: false
      transitionIn: 'elastic'
      transition: 'scrollHorizontal'
      onStart: start: () => @removeHref()
      onClose: finish: () => @stopPlay()

  removeHref: ->
    $('a[href]:not([data-rel])').each () ->
      href = this.href
      $(this).removeAttr('href').click () ->
        window.location = href

  stopPlay: ->
    $.each $('audio'), () ->
      this.pause()
      this.currentTime = 0

  goToMainSection: ->
    $('html, body').animate {
      scrollTop: $(".main-section").offset().top
    }, 800

  changeHeaderTextOpacity: ->
    offset = $(document).scrollTop()
    opacity = (@fadeUntil - offset) / @fadeHeight
    $('.hero-heading, .hero-subheading, #goto-main-section').css 'opacity', opacity
