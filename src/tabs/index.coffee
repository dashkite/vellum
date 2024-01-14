import * as M from "@dashkite/joy/metaclass"
import * as C from "@dashkite/rio"
import html from "./html"
import css from "./css"
import * as Ks from "@dashkite/katana/sync"

import {
  mutate
  getContext
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
        C.within "button[role='tab']", [
          deselect
          hide
          select
          reveal
          C.dispatch "select"
        ]

] ] ]
