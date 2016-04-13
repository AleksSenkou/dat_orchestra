class DatOrchestra.Views.Home extends Backbone.View
  el: 'body'
  fadeHeight: 200

  events:
    'click #goto-main-section' : 'goToMainSection'

  initialize: ->
    @lightcase = new DatOrchestra.ViewsHelpers.LightCase()
    @base = new DatOrchestra.ViewsHelpers.Base()
    @localeSelect = new DatOrchestra.ViewsHelpers.LocaleSelect()
    @fadeUntil = $('.heading').position().top
    @changeHeaderTextOpacityEvent()

  render: ->
    @lightcase.render(audioPlayer: true)
    @base.removeHrefs()
    @localeSelect.render()

  changeHeaderTextOpacityEvent: ->
    $(window).bind 'scroll', () => @changeHeaderTextOpacity()

  goToMainSection: ->
    $('html, body').animate {
      scrollTop: $(".main-section").offset().top
    }, 800

  changeHeaderTextOpacity: ->
    offset = $(document).scrollTop()
    opacity = (@fadeUntil - offset) / @fadeHeight
    $('.heading, .subheading, #goto-main-section').css 'opacity', opacity
