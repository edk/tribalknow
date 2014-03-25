# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  post_changed_text_to_server = (e) ->
    this_id = $(this).attr('id')
    console.log('here', this_id)
    console.log('data= ', data)

  $('[contenteditable=true]').on 'blur', post_changed_text_to_server
