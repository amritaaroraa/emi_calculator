// Generated by ReScript, PLEASE EDIT WITH CARE

import * as App from "./App.bs.js";
import * as React from "react";
import * as ReactDom from "react-dom";
import * as Caml_option from "rescript/lib/es6/caml_option.js";

import './index.css';
;

var rootQuery = document.querySelector("#root");

function render(prim0, prim1) {
  ReactDom.render(prim0, prim1);
}

function querySelector(prim) {
  return Caml_option.nullable_to_opt(document.querySelector(prim));
}

if (!(rootQuery == null)) {
  var prim0 = React.createElement(App.make, {});
  ReactDom.render(prim0, rootQuery);
}

var rootQuery$1 = (rootQuery == null) ? undefined : Caml_option.some(rootQuery);

export {
  rootQuery$1 as rootQuery,
  render ,
  querySelector ,
}
/*  Not a pure module */