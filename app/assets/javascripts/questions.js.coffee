# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $ () ->
    anchor_value
    stripped_url = document.location.toString().split("#")
    if (stripped_url.length > 1)
      anchor_value = stripped_url[1]
    
    if anchor_value.length > 0
      # $("##{focus}").css({ 'background-color': 'yellow' })
      $("##{anchor_value}").highlight()
