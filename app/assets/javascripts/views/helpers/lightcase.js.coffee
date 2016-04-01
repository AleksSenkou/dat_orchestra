class DatOrchestra.ViewsHelpers.LightCase extends Backbone.View
  el: '.featured-thumbnail'

  events:
    'click .play-icon-block' : 'openLightcase'

  initialize: ->
    @base = new DatOrchestra.ViewsHelpers.Base()

  render: (audioPlayer) ->
    $('a[data-rel^=lightcase]').lightcase
      forceWidth: true
      forceHeight: true
      overlayOpacity: 0.95
      showSequenceInfo: false
      closeOnOverlayClick: false
      audioPlayer: audioPlayer
      transitionIn: 'elastic'
      transition: 'scrollHorizontal'
      onStart: start: () => @base.removeHrefs()
      onClose: finish: () => @stopPlay()

  stopPlay: ->
    $.each $('audio'), () ->
      this.pause()
      this.currentTime = 0

  openLightcase: (e) ->
    $(e.target).parent('.composition').children('.play').click()
