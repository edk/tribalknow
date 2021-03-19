import React from "react";
import ReactDOM from "react-dom";
import MarkdownEditor from "./markdown_editor/MarkdownEditor.jsx";

const form = document.querySelector("form.edit_topic") || document.querySelector("form.new_topic");
const railsTextArea = document.getElementById("topic_content");

form.onsubmit = function () {
  const reactTextArea = document.querySelector(".markdown_editor__editor");
  railsTextArea.value = reactTextArea.value;
};

railsTextArea.style.cssText = "display: none;";

const mountPoint = document.getElementById("react-markdown-editor");
ReactDOM.render(<MarkdownEditor />, mountPoint);
