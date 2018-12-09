/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */

$(function() {
  const image_url = $('form.edit_user').attr('action')+"/avatar";
  const opts = {
    clickable: true,
    autoProcessQueue: true,
    headers: { 
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    url: image_url,
    previewTemplate: "<span></span>",
    init() {

      this.on("success", function(file, response) {
        $("#avatar_drop img").attr("src", response.url);
        const width = $('.nav_avatar img').attr('width');
        $('.nav_avatar img').attr({ src: response.url, size: `${width}x${width}` });
        return $("#avatar_drop").trigger("change", response);
      });

      return this.on("error", (file, response) => console.log(file, response));
    }
  };

  $('#avatar_drop').dropzone( opts );
  
  $("#avatar_drop").on("change", function(ev, result) {
    const src = $(this).find("img").attr("src");
    if (result.user_avatar) {
      $('#reset_to_gravatar').show();
      return $('#set_your_avatar').hide();
    } else {
      $('#reset_to_gravatar').hide();
      return $('#set_your_avatar').show();
    }
  });

  $("#reset_to_gravatar").on("click", ev =>
    $.post(image_url, {reset: true}, function(data) {
      $('#avatar_drop img').attr("src", data.url);
      $("#avatar_drop").trigger("change", data);
      const width = $('.nav_avatar img').attr('width');
      return $('.nav_avatar img').attr({ src: data.url, size: `${width}x${width}` });
    })
  );

  return $("#avatar_drop img,#set_your_avatar").on("click", function(ev) {
    ev.stopPropagation();
    return $('#avatar_drop').trigger('click');
  });
});

