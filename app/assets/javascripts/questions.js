/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(() =>
  $(function() {
    let anchor_value;
    anchor_value;
    const stripped_url = document.location.toString().split("#");
    if (stripped_url.length > 1) {
      anchor_value = stripped_url[1];
    }
    
    if (anchor_value && (anchor_value.length > 0)) {
      return $(`#${anchor_value}`).highlight();
    }
  })
);
