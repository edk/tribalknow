# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # $('#question_text').ckeditor();
  if $('#tags').length > 0
    all_tags = JSON.parse($('#tags').html())
    if all_tags && all_tags.length > 0
      $('.select2-with-tags').select2({tags:all_tags })

  post_changed_text_to_server = (e) ->
    this_id = $(this).attr('id')
    console.log('here', this_id)
    data = CKEDITOR.instances[this_id].getData()
    console.log('data= ', data)

  $('[contenteditable=true]').on 'blur', post_changed_text_to_server
