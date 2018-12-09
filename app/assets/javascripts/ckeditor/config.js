/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
CKEDITOR.editorConfig = function(config) {
  config.toolbarGroups = [
      // { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
      // { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
      { name: 'links' },
      { name: 'insert' },
      // { name: 'forms' },
      { name: 'tools' },
      // { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
      // { name: 'others' },
      // '/',
      { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
      // { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
      { name: 'styles' },
      { name: 'colors' }
      // { name: 'about' }
  ];
  config.toolbarStartupExpanded = false;
  config.toolbarCanCollapse = true;
  return true;
};
