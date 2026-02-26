import * as Meta from "@dashkite/joy/metaclass"
import * as Rio from "@dashkite/rio"
import * as K from "@dashkite/katana/async"
import * as Ks from "@dashkite/katana/sync"
import { Tab, Panel } from "./helpers"
import html from "./html"
import css from "./css"

class extends Rio.Handle

  Meta.mixin @, [
    Rio.tag "vellum-tabs"
    Rio.diff
    Rio.initialize [
      Rio.shadow
      Rio.sheets [ css ]
      Rio.activate [
        K.peek ( handle ) ->
          if !( Tab.selected handle )?
            Tab.select handle, "[slot=tab]:first-child"
        Rio.render html
      ]
      Rio.click "[slot=tab]", [
        Ks.poke ( event ) -> event.target.closest "[slot=tab]"
        Ks.peek ( target, handle ) -> Tab.select handle, target
      ]
    ]
  ]

