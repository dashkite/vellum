import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Obj from "@dashkite/joy/object"
import DOM from "@dashkite/dominator"
import * as Rio from "@dashkite/rio"
import * as K from "@dashkite/katana/async"
import * as Posh from "@dashkite/posh"

import html from "./html"
import css from "./css"
    
class extends Rio.Handle

  Meta.mixin @, [
    Rio.tag "vellum-field"
    Rio.diff
    Rio.initialize [
      Rio.shadow
      Rio.sheets [
        css
        Posh.component
        Posh.forms
        Posh.icons
      ]

      Rio.activate [
        Rio.dom
        K.poke Fn.pipe [
          Fn.map [
            DOM.attributes
            DOM.slots
          ]
          Fn.spread Obj.merge
        ]
        Rio.render html
      ]

      # TODO we should also respond to changes to the light DOM slots
      Rio.modify [ "name", "type", "value", "required", "disabled" ], [
        Rio.dom
        K.poke DOM.slots
        K.poke Obj.merge
        Rio.render html
      ]

      Rio.event "input", [
        Rio.intercept
        K.peek ( event, handle ) ->
          handle.dom.value = event.target.value
          handle.dispatch "input", detail: handle.dom
      ]
    ]
    Rio.field
  ]
