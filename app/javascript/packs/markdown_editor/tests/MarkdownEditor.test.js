import React from "react";
import { render } from "@testing-library/react";
import MarkdownEditor from "../MarkdownEditor";

let container;
let renderComponent = props => {
  props = props || { text: "text data" };
  container = render(<MarkdownEditor {...props} />).container;
};

test("MarkdownEditor", () => {
  renderComponent();
  expect(container.querySelector(".markdown_editor")).toBeTruthy();
  expect(container.querySelector("textarea[name='topic[content]']")).toBeTruthy();
  expect(container.querySelector(".markdown_editor__toolbar")).toBeTruthy();
});
