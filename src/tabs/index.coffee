import * as M from "@dashkite/joy/metaclass"
import * as C from "@dashkite/rio"
import html from "./html"
import css from "./css"
import * as Ks from "@dashkite/katana/sync"
import * as K from "@dashkite/katana/async"
import { Tab, Panel } from "./helpers"

class extends C.Handle

  M.mixin @, [
    C.tag "vellum-tabs"
    C.diff
    C.initialize [
      C.shadow
      C.sheets [ css ]
      C.activate [
        K.peek ( handle ) ->
          if !( Tab.selected handle.dom )?
            Tab.select handle.dom, "[slot=tab]:first-child"
        C.render html
      ]
      C.click "[slot=tab]", [
        K.peek ( event, handle ) ->
          Tab.select handle.dom, event.target.closest "[slot=tab]"
      ]
    ]
  ]

