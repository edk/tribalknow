import React from "react";
import { render } from "@testing-library/react";
import Toolbar from "../Toolbar";

const setCallback = x => x;

const renderComponent = props => {
  props = props || {
    currentView: "editor",
    setCurrentView: setCallback,
    fontStyle: "normal",
    setFontStyle: setCallback,
    autoScroll: true,
    setAutoScroll: setCallback
  };

  return render(<Toolbar {...props} />);
};

test("Toolbar renders", () => {
  const { container, getByText } = renderComponent();
  expect(container.querySelector(".markdown_editor__toolbar")).toBeTruthy();
});

test("Toolbar has buttons", () => {
  const { container, getByText } = renderComponent();

  expect(getByText("Editor")).toBeTruthy();
  expect(getByText("Preview")).toBeTruthy();
  expect(getByText("Preview")).toBeTruthy();
});
