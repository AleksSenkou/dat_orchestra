class DatOrchestra.ViewsHelpers.Base extends Backbone.View
  el: 'body'

  removeHrefs: ->
    $('a[href]:not([data-rel])').each () ->
      href = this.href
      $(this).removeAttr('href').click () ->
        window.location = href
