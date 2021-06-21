import * as M from "@dashkite/joy/metaclass"
import * as F from "@dashkite/joy/function"
import * as T from "@dashkite/joy/type"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import * as ks from "@dashkite/katana/sync"
import html from "./html"
import css from "./css"

class extends c.Handle

  M.mixin @, [
    c.tag "vellum-drawer"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        c.description
        c.render html
      ]
      c.event "click", [
        c.within "input#toggle", [ c.stop ]
] ] ]
