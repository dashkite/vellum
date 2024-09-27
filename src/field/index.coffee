import * as Meta from "@dashkite/joy/metaclass"
import * as Rio from "@dashkite/rio"
import * as K from "@dashkite/katana/async"
import * as Posh from "@dashkite/posh"

import html from "./html"
import css from "./css"
    
class extends Rio.Handle

  hasSlot: ( name ) -> ( @slot name  )?

  slot: ( name ) -> @dom.querySelector "[slot='#{ name }']"

  options: -> @dom.querySelector "datalist"

  Meta.mixin @, [
    Rio.tag "vellum-field"
    Rio.diff
    Rio.initialize [
      Rio.shadow
      Rio.sheets [
        css...
        Posh.component
        Posh.forms
        Posh.icons
      ]

      Rio.activate [
        Rio.dom
        Rio.attributes
        K.poke ( attributes, handle ) ->
          { 
            attributes...
            options: handle.options()
            slots:
              input: handle.hasSlot "input"
              hint: handle.hasSlot "hint"
              error: handle.hasSlot "error"
          }
        Rio.render html
      ]

      Rio.modify [ "name", "type", "value", "required" ], [
        K.poke ( attributes, handle ) ->
          { 
            attributes...
            options: handle.options()
            slots:
              input: handle.hasSlot "input"
              hint: handle.hasSlot "hint"
              error: handle.hasSlot "error"
          }
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
