/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'jquery/dist/jquery';

import $ from 'jquery';
global.jQuery = $;
global.$ = $;

import { } from 'jquery-ujs'

import 'jquery.easing/jquery.easing.js';

import '@fortawesome/fontawesome-free/js/all';

import 'bootstrap/dist/js/bootstrap';

import 'darkly';
import 'lux';
import 'flatly';
import 'cosmo';
import 'lumen';

import { EditorState } from "prosemirror-state"
import { EditorView } from "prosemirror-view"
import { Schema, DOMParser } from "prosemirror-model"
//import {schema} from "prosemirror-schema-basic"
import { schema, defaultMarkdownParser, defaultMarkdownSerializer } from 'prosemirror-markdown'
import { addListNodes } from "prosemirror-schema-list"
//import {exampleSetup} from "prosemirror-example-setup"
import { exampleSetup } from '../prosemirror_setup/exampleSetup'

// import 'stylesheets/site_styles.scss'
//import 'prosemirror-view/style/prosemirror.css'

import '../stylesheets/prosemirror.scss'




document.addEventListener("DOMContentLoaded", function (event) {
  class MarkdownView {
    constructor(target, content) {
      this.textarea = target.appendChild(document.createElement("textarea"))
      this.textarea.value = content
    }

    get content() { return this.textarea.value }
    focus() { this.textarea.focus() }
    destroy() { this.textarea.remove() }
  }

  class ProseMirrorView {
    constructor(target, content) {
      this.view = new EditorView(target, {
        state: EditorState.create({
          doc: defaultMarkdownParser.parse(content),
          plugins: exampleSetup({ schema })
        })
      })
    }

    get content() {
      return defaultMarkdownSerializer.serialize(this.view.state.doc)
    }
    focus() { this.view.focus() }
    destroy() { this.view.destroy() }
  }

  let place = document.querySelector("#editor")
  let view = new MarkdownView(place, document.querySelector("#content").textContent)

  document.querySelectorAll("input[type=radio]").forEach(button => {
    button.addEventListener("change", () => {
      if (!button.checked) return
      let View = button.value == "markdown" ? MarkdownView : ProseMirrorView
      if (view instanceof View) return
      let content = view.content
      view.destroy()
      view = new View(place, content)
      view.focus()
    })
  })

  // const mySchema = new Schema({
  //   nodes: addListNodes(schema.spec.nodes, "paragraph block*", "block"),
  //   marks: schema.spec.marks
  // })

  // window.view = new EditorView(document.querySelector("#editor"), {
  //   state: EditorState.create({
  //   doc: DOMParser.fromSchema(mySchema).parse(document.querySelector("#content")),
  //   plugins: exampleSetup({schema: mySchema})
  //   })
  // })
})
