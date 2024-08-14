import * as Meta from "@dashkite/joy/metaclass"
import * as K from "@dashkite/katana/async"
import * as Ks from "@dashkite/katana/sync"
import * as Rio from "@dashkite/rio"
import * as Posh from "@dashkite/posh"

import events from "./events"
import html from "./html"
import css from "./css"

class extends Rio.Handle

  Meta.mixin @, [
    Rio.tag "vellum-autocomplete"
    Rio.diff

    Rio.initialize [
      Rio.shadow
      Rio.sheets [ 
        Posh.component
        Posh.forms,
        css
      ]

      Rio.describe [
        Rio.render html
      ]
    ]

    Rio.field
    events

  ]