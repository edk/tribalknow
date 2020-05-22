/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
$.widget("custom.catcomplete", $.ui.autocomplete, {
  _create() {
    this._super();
    return this.widget().menu("option", "items", "> :not(.ui-autocomplete-category)");
  },

  _renderMenu(ul, items) {
    const that = this;
    let currentCategory = "";
    return $.each(items, function(index, item) {
      let li = undefined;
      if (item.category !== currentCategory) {
        ul.append(`<li class='ui-autocomplete-category'>${item.category}</li>`);
        currentCategory = item.category;
      }
      li = that._renderItemData(ul, item);
      if (item.category) { return li.attr("aria-label", item.category + " : " + item.label); }
    });
  }
}
);

$(() =>
  $("#q").catcomplete({
    source(request, response) {
      return $.ajax({
        url: "/searches/autocomplete",
        dataType: "json",
        data: {
          q: request.term
        },
        success(data) {
          response(data.slice(0, 25));
        }
      });
    },
    delay: 0,
    select(event, ui) {
      $(event.target).val(ui.item.title);
      window.location = ui.item.url;
      return false;
    }
  })
);
