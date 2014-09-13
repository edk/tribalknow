# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # make the standard code mirror div bigger than normal
  $('.CodeMirror').css({'height': '25em'})

  opts =
    clickable: ".instructions",
    autoProcessQueue: true, #When set to false you have to call myDropzone.processQueue() yourself in order to upload the dropped files. See below for more information on handling queues.
    #thumbnailWidth, thumbnailHeight, addRemoveLinks:
    #previewsContainer: , # defines where to display the file previews – if null the Dropzone element is used. Can be a plain HTMLElement or a CSS selector. The element should have the dropzone-previews class so the previews are displayed properly
    #previewTemplate: #is a string that contains the template used for each dropped image. Change it to fulfill your needs but make sure to properly provide all elements.
    headers: 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

  if $('.drop_target').length > 0 && url = $('.drop_target').attr('data-url')
    opts.url = url
    dz_element = $('.drop_target').dropzone opts

    dz = Dropzone.forElement(dz_element.get(0))

    dz.on 'complete', (file, a, b) ->
      console.log('complete dropzone')
    dz.on 'uploadprogress', (file, a, b) ->
      console.log('uploadprogress dropzone')
  else if $('.icon_drop_target').length > 0
    $('.icon_drop_target').each (index, elem) ->
      $elem = $(elem)
      if $elem.attr('url') && !$elem.attr("has-dropzone")
        $elem.attr("has-dropzone", true) # to avoid double initializing
        opt2 = _.clone(opts)
        opt2.clickable = null
        opt2.url = $(elem).attr('url')
        opt2.createImageThumbnails = false
        opt2.previewTemplate = "<div style='display:none'></div>"
        dz_element = $(elem).dropzone opt2
        dz = Dropzone.forElement(dz_element.get(0))
        dz.on "success", (file, resp) ->
          url = resp.url
          $(this.element).find('img').attr({src: url})




