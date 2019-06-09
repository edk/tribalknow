/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * DS205: Consider reworking code to avoid use of IIFEs
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */

$(function() {
  $('.datepicker').datepicker();

  const enable_save = function() {
    $('#save_btn').removeAttr('disabled');
    return $('#save_btn').val('Save');
  };
  const disable_save = function() {
    $('#save_btn').attr('disabled', 'disabled');
    return $('#save_btn').val('Please wait until upload finishes');
  };

  const opts = {
    clickable: true,
    autoProcessQueue: true,
    paramName: 'video_asset[asset]',
    maxFilesize: $('#max_file_size').val() || 1000,
    uploadMultiple: false,
    addRemoveLinks: false,
    acceptedFiles: 'video/mp4,video/quicktime,video/m4v,video/webm',
    headers: { 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    url: $('form.upload_form').attr('action'),
    method: 'patch',
    init() {
      this.on("error", (file, errorMsg) =>
        (() => {
          const result = [];
          for (let key in errorMsg) {
            const val = errorMsg[key];
            const err_val = val.join(', ').toString();
            result.push($('.dz-error-message').html(`${key}: ${err_val}`).show());
          }
          return result;
        })()
      );

      this.on("sending", function(file, xhrObj, formData) {
        disable_save();
        const elements = $(this.element).parents('form').find('input,textarea');
        return (() => {
          const result = [];
          for (let el of Array.from(elements)) {
            const matches = $(el).attr('name').match(/\[(\S+)\]/);
            if (matches) {
              result.push(formData.append(`video_asset[${matches[1]}]`, $(el).val()));
            }
            else {}
          }
          return result;
        })();
      });
            // console.log "matches is null (#{matches})"

      return this.on("success", function(file, responseText) {
        enable_save();
        return alert('Upload complete!');
      });
    }
  };

  $('.video_drop').dropzone( opts );

  return $("form.upload_form").on("submit", function() {
    let savable = !$('#save_btn').attr('disabled');
    console.log('savable = ',savable);
    let missing_required = false;

    _.each($('.upload_form input.required'), function(elem) {
      if ($(elem).val() === '') {
        return missing_required = true;
      }
    });

    if (missing_required) {
      alert('Please fill out the required fields');
      savable = false;
      return false;
    }

    if (!savable) {
      alert('Please wait until upload is complete');
    }

    if (!savable) {
      return false;
    } else {
      return true;
    }
  });
});

