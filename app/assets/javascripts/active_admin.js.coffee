#= require active_admin/base
#= require underscore
#= require underscore.string

$(document).ready () ->
  if location.pathname.includes "/admin/members/"
    page = new EditMemberPage()
    page.render()
  else if location.pathname.includes "/admin/compositions/"
    page = new EditCompositionPage()
    page.render()

class EditCompositionPage
  render: ->
    @addMemberEvent()
    @removeMemberEvent()

  addMemberEvent: ->
    $('#add-member').change (e) ->
      $.ajax
        url: "/compositions_members"
        type: 'POST'
        data:
          member_id: $(e.target).val()
          composition_id: $(e.target).data("composition-id")
        complete: -> location.reload()

  removeMemberEvent: ->
    $('.edit-composition-member > img').click (e) ->
      $.ajax
        url: "/compositions_members/1"
        type: 'DELETE'
        data:
          member_id: $(e.target).data("member-id")
          composition_id: $(e.target).data("composition-id")
        complete: -> location.reload()

class EditMemberPage
  render: ->
    @addCompositionEvent()
    @removeCompositionEvent()
    @addInstrumentEvents()
    @removeInstrumentEvents()

  addCompositionEvent: ->
    $('#add-composition').change (e) ->
      $.ajax
        url: "/compositions_members"
        type: 'POST'
        data:
          member_id: $(e.target).data("member-id")
          composition_id: $(e.target).val()
        complete: -> location.reload()

  removeCompositionEvent: ->
    $('.edit-member-composition > img').click (e) ->
      $.ajax
        url: "/compositions_members/1"
        type: 'DELETE'
        data:
          member_id: $(e.target).data("member-id")
          composition_id: $(e.target).data("composition-id")
        complete: -> location.reload()

  addInstrumentEvents: ->
    _.each $('.edit-member-instrument > img:not(.selected)'), (instrument) =>
      @addInstrumentEvent instrument

  addInstrumentEvent: (instrument) ->
    $(instrument).click (e) =>
      $.ajax
        url: '/member_instruments'
        type: 'POST'
        data:
          member_id: $(e.target).data("member-id")
          instrument_id: $(e.target).data("instrument-id")
        complete: =>
          $(e.target).addClass('selected')
          $(e.target).off()
          @removeInstrumentEvent(e.target)

  removeInstrumentEvents: ->
    _.each $('.edit-member-instrument > img.selected'), (instrument) =>
      @removeInstrumentEvent instrument

  removeInstrumentEvent: (instrument) ->
    $(instrument).click (e) =>
      $.ajax
        url: '/member_instruments/1'
        type: 'DELETE'
        data:
          member_id: $(e.target).data("member-id")
          instrument_id: $(e.target).data("instrument-id")
        complete: =>
          $(e.target).removeClass('selected')
          $(e.target).off()
          @addInstrumentEvent(e.target)
