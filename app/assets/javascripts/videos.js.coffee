
$ ->
  $('.datepicker').datepicker()

  enable_save = () ->
    $('#save_btn').removeAttr('disabled')
    $('#save_btn').val('Save')
  disable_save = () ->
    $('#save_btn').attr('disabled', 'disabled')
    $('#save_btn').val('Please wait until upload finishes')

  opts =
    clickable: true
    autoProcessQueue: true
    paramName: 'video_asset[asset]'
    maxFilesize: $('#max_file_size').val() || 1000
    uploadMultiple: false
    addRemoveLinks: false
    acceptedFiles: 'video/mp4,video/quicktime'
    headers: 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    url: $('form.upload_form').attr('action')
    method: 'patch'
    init: () ->
      this.on "error", (file, errorMsg) ->
        for key, val of errorMsg
          err_val = val.join(', ').toString()
          $('.dz-error-message').html("#{key}: #{err_val}").show()

      this.on "sending", (file, xhrObj, formData) ->
        disable_save()
        elements = $(this.element).parents('form').find('input,textarea')
        for el in elements
          matches = $(el).attr('name').match(/\[(\S+)\]/)
          if matches
            formData.append("video_asset[#{matches[1]}]", $(el).val())
          else
            # console.log "matches is null (#{matches})"

      this.on "success", (file, responseText) ->
        enable_save()
        alert('Upload complete!')

  $('.video_drop').dropzone( opts )

  $("form.upload_form").on "submit", () ->
    savable = !$('#save_btn').attr('disabled')
    console.log('savable = ',savable)
    missing_required = false

    _.each $('.upload_form input.required'), (elem) ->
      if $(elem).val() == ''
        missing_required = true

    if missing_required
      alert('Please fill out the required fields')
      savable = false
      return false

    if !savable
      alert('Please wait until upload is complete')

    if !savable
      return false
    else
      return true

