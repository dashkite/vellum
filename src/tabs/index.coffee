import * as M from "@dashkite/joy/metaclass"
import * as C from "@dashkite/carbon"
import html from "./html"
import css from "./css"

import {
  mutate
  getContext
  contains
  matches
  select
  reveal
  deselect
  hide
} from "./helpers"

class extends C.Handle

  M.mixin @, [
    C.tag "vellum-tabs"
    C.diff
    C.initialize [
      C.shadow
      C.sheets main: css
      C.activate [
        getContext
        C.render html
      ]
      mutate [
        getContext
        C.render html
      ]
      C.event "click", [
        contains "button", [
          matches "[role='tab']", [
            deselect
            hide
            select
            reveal            
          ]
        ]

] ] ]
