/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  let dz, dz_element, url;
  const code_field = $('#in textarea:visible');
  code_field.on("keyup", () => code_field.addClass("codeMirrorDirty"));

  // $('#in textarea:visible').parents('form').find('input[type=submit]').on ""
  code_field.parents('form').on("submit", function() {
    code_field.removeClass('codeMirrorDirty');
    return true;
  });

  const unloadPage = function(e) {
    if ($('#in textarea.codeMirrorDirty:visible').length > 0) {
      return 'You have unsaved changes on this page.  Do you want to leave?';
    } else {
      return null;
    }
  };

  window.onbeforeunload = unloadPage;

  // make the standard code mirror div bigger than normal
  $('.CodeMirror').css({'height': '25em'});

  const opts = {
    clickable: ".instructions",
    autoProcessQueue: true,
    headers: { 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  };

  if (($('.drop_target').length > 0)  && (url = $('.drop_target').attr('data-url'))) {
    opts.url = url;
    const drop_targets = $('.drop_target');
    if (drop_targets.data("has_dropzone")) { return; }
    drop_targets.data("has_dropzone", 1);
    dz_element = drop_targets.dropzone(opts);

    dz = Dropzone.forElement(dz_element.get(0));

    dz.on('complete', (file, a, b) => console.log('complete dropzone'));
    return dz.on('uploadprogress', (file, a, b) => console.log('uploadprogress dropzone'));

  } else if ($('.icon_drop_target').length > 0) {
    return $('.icon_drop_target').each(function(index, elem) {
      const $elem = $(elem);
      if ($elem.attr('url') && !$elem.attr("has-dropzone")) {
        $elem.attr("has-dropzone", true); // to avoid double initializing
        const opt2 = _.clone(opts);
        opt2.clickable = null;
        opt2.url = $(elem).attr('url');
        opt2.createImageThumbnails = false;
        opt2.previewTemplate = "<div style='display:none'></div>";
        dz_element = $(elem).dropzone(opt2);
        dz = Dropzone.forElement(dz_element.get(0));
        return dz.on("success", function(file, resp) {
          ({ url } = resp);
          return $(this.element).find('img').attr({src: url});
        });
      }
    });
  }
});

