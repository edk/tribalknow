import React, { useState, useCallback } from "react";
import classNames from "classnames";

const activeButtonClasses = active => {
  return { "btn-outline-secondary": !active, "btn-secondary": active };
};

export default function Toolbar({ currentView, setCurrentView, fontStyle, setFontStyle, autoScroll, setAutoScroll }) {
  return (
    <div className="markdown_editor__toolbar mt-4 mb-2" role="toolbar">
      <div className="btn-group mr-4">
        <button
          type="button"
          className={classNames("btn", activeButtonClasses(currentView == "editor"))}
          onClick={() => setCurrentView("editor")}
        >
          <i className="fa fa-edit pr-1" />
          Editor
        </button>
        <button
          type="button"
          className={classNames("btn", activeButtonClasses(currentView == "preview"))}
          onClick={() => setCurrentView("preview")}
        >
          <i className="fa fa-file-alt pr-1" />
          Preview
        </button>
        <button
          type="button"
          className={classNames("btn", activeButtonClasses(currentView == "both"))}
          onClick={() => setCurrentView("both")}
        >
          <i className="fa fa-columns pr-1" />
          Both
        </button>
      </div>

      <div className="form-check form-check-inline border py-1 px-2 align-bottom">
        <span className="pr-2">Editor Font Style</span>

        <input
          id="editor_font_radio_normal"
          className="form-check-input pr-1"
          type="radio"
          value="normal"
          checked={fontStyle == "normal"}
          onChange={() => setFontStyle("normal")}
        />

        <label htmlFor="editor_font_radio_normal" className="form-check-label pr-2">
          Normal
        </label>
        <input
          id="editor_font_radio_monospace"
          className="form-check-input pr-1"
          type="radio"
          value="monospace"
          checked={fontStyle == "monospace"}
          onChange={() => setFontStyle("monospace")}
        />
        <label htmlFor="editor_font_radio_monospace" className="form-check-label monospace">
          Monospace
        </label>
      </div>

      {currentView == "both" && (
        <div className="form-check form-check-inline border py-1 px-2 align-bottom">
          <input
            id="editor_auto_scroll"
            className="form-check-input pr-1"
            type="checkbox"
            value="autoScroll"
            checked={autoScroll}
            onChange={() => setAutoScroll(!autoScroll)}
          />

          <label htmlFor="editor_auto_scroll" className="form-check-label">
            Synchronized Scrolling
          </label>
        </div>
      )}
    </div>
  );
}
