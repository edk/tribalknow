
$ ->
  image_url = $('form.edit_user').attr('action')+"/avatar"
  opts =
    clickable: true
    autoProcessQueue: true
    headers: 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    url: image_url
    previewTemplate: "<span></span>"
    init: ->

      this.on "success", (file, response) ->
        $("#avatar_drop img").attr("src", response.url)
        width = $('.nav_avatar img').attr('width')
        $('.nav_avatar img').attr({ src: response.url, size: "#{width}x#{width}" })
        $("#avatar_drop").trigger("change", response)

      this.on "error", (file, response) ->
        console.log file, response

  $('#avatar_drop').dropzone( opts )
  
  $("#avatar_drop").on "change", (ev, result) ->
    src = $(this).find("img").attr("src")
    if result.user_avatar
      $('#reset_to_gravatar').show()
      $('#set_your_avatar').hide()
    else
      $('#reset_to_gravatar').hide()
      $('#set_your_avatar').show()

  $("#reset_to_gravatar").on "click", (ev) ->
    $.post image_url, {reset: true}, (data) ->
      $('#avatar_drop img').attr("src", data.url)
      $("#avatar_drop").trigger("change", data)
      width = $('.nav_avatar img').attr('width')
      $('.nav_avatar img').attr({ src: data.url, size: "#{width}x#{width}" })

  $("#avatar_drop img,#set_your_avatar").on "click", (ev) ->
    ev.stopPropagation()
    $('#avatar_drop').trigger('click')

