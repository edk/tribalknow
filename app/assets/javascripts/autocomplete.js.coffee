$.widget "custom.catcomplete", $.ui.autocomplete,
  _create: ->
    @_super()
    @widget().menu "option", "items", "> :not(.ui-autocomplete-category)"

  _renderMenu: (ul, items) ->
    that = this
    currentCategory = ""
    $.each items, (index, item) ->
      li = undefined
      unless item.category is currentCategory
        ul.append "<li class='ui-autocomplete-category'>" + item.category + "</li>"
        currentCategory = item.category
      li = that._renderItemData(ul, item)
      li.attr "aria-label", item.category + " : " + item.label  if item.category

$ ->
  $("#q").catcomplete
    source: "/autocomplete"
    delay: 0
    select: (event, ui) ->
      $(event.target).val ui.item.title
      window.location = ui.item.url
      false