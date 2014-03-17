// Hacked and used https://github.com/jbt/markdown-editor which uses the lovely WTFPL
// http://codemirror.net/
// Another option might be to check out http://jrmoran.com/playground/markdown-live-editor/
//= require md-editor/marked.js
//= require md-editor/highlight.pack.js
//= require md-editor/codemirror/lib/codemirror.js
//= require md-editor/codemirror/xml/xml.js
//= require md-editor/codemirror/markdown/markdown.js
//= require md-editor/codemirror/gfm/gfm.js
//= require md-editor/codemirror/javascript/javascript.js
//= require md-editor/rawinflate.js
//= require md-editor/rawdeflate.js


var setup_md_code_mirror = function() {
  var URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
  navigator.saveBlob = navigator.saveBlob || navigator.msSaveBlob || navigator.mozSaveBlob || navigator.webkitSaveBlob;
  window.saveAs = window.saveAs || window.webkitSaveAs || window.mozSaveAs || window.msSaveAs;

  // Because highlight.js is a bit awkward at times
  var languageOverrides = {
    js: 'javascript',
    html: 'xml'
  }

  marked.setOptions({
    highlight: function(code, lang){
      if(languageOverrides[lang]) lang = languageOverrides[lang];
      return hljs.LANGUAGES[lang] ? hljs.highlight(lang, code).value : code;
    }
  });

  function update(e){
    var val = e.getValue();
    setOutput(val);
  }

  function setOutput(val){
    $('#out').html(marked(val));
  }

  var editor = CodeMirror.fromTextArea($('#in textarea')[0], {
    mode: 'gfm',
    lineNumbers: true,
    matchBrackets: true,
    lineWrapping: true,
    theme: 'default',
    onChange: update
  });

  document.addEventListener('drop', function(e){
    e.preventDefault();
    e.stopPropagation();

    var theFile = e.dataTransfer.files[0];
    var theReader = new FileReader();
    theReader.onload = function(e){
      editor.setValue(e.target.result);
    };

    theReader.readAsText(theFile);
  }, false);

  function save(){
    var code = editor.getValue();
    var blob = new Blob([code], { type: 'text/plain' });
    saveBlob(blob);
  }

  function saveBlob(blob){
    var name = "untitled.md";
    if(window.saveAs){
      window.saveAs(blob, name);
    }else if(navigator.saveBlob){
      navigator.saveBlob(blob, name);
    }else{
      url = URL.createObjectURL(blob);
      var link = document.createElement("a");
      link.setAttribute("href",url);
      link.setAttribute("download",name);
      var event = document.createEvent('MouseEvents');
      event.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
      link.dispatchEvent(event);
    }
  }

  // document.addEventListener('keydown', function(e){
  //   if(e.keyCode == 83 && (e.ctrlKey || e.metaKey)){
  //     e.preventDefault();
  //     save();
  //     return false;
  //   }
  // })

  update(editor);
  // editor.focus();

};

$(function(){
  if ($('#in').length>0 && $('#out').length>0) {
    setup_md_code_mirror();
  }
});
