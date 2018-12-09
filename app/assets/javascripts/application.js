// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require select2
//= require underscore
//= require foundation
// require foundation/foundation.tooltip
//= require mdedit
//= require dropzone
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require jquery-ui
//= require autocomplete
//= require ahoy
//= require Chart.bundle
//= require chartkick

// require google-code-prettify/prettify
// require_tree .

Dropzone.autoDiscover = false;

$(function(){
  $(document).foundation();
  $('.select2').select2();
  if ($('#tags').length > 0) {
    var all_tags = JSON.parse($('#tags').html());
    if (all_tags && all_tags.length > 0) {
      $('.select2-with-tags').select2({tags:all_tags });
    }
  }
  
  $(document.body).on("click", ".close", function(ev){
    var panel = $(this).parents('[data-alert]');
    if (panel.data('href')) {
      $.post(panel.data('href'));
    }
    $(ev).remove();
    ev.preventDefault();
  });

  if (hljs) {
    $('pre code').each(function(i,e){
      var lang = $(e).parent('pre').attr('lang');
      if (hljs.LANGUAGES[lang]) {
        var code = $(e).html();
        $(e).html(_.unescape(hljs.highlight(lang, code).value));
      }
    });
  }

  // clicking on the glowing panel gives us a bigger click target
  $('.glow').on('click', function(e){
    var link = $(this).find('a').get(0);
    if (e.target == link) return true;
    window.location = $(link).attr('href');
    return false;
  });

  $('.best_in_place').best_in_place();

  $(document).on('opened.fndtn.reveal', '[data-reveal]', function(){
    $(".reveal-modal.open").find("input").filter(":visible:first").focus();
  })
});

jQuery.fn.highlight = function() {
   $(this).each(function() {
        var el = $(this);
        el.before("<div/>")
        el.prev()
            .width(el.width())
            .height(el.height())
            .css({
                "position": "absolute",
                "background-color": "#ffff99",
                "opacity": ".9"   
            })
            .fadeOut(1500);
    });
}


$(function(){ $(document).foundation(); });
