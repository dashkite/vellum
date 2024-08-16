import * as Meta from "@dashkite/joy/metaclass"
import * as Rio from "@dashkite/rio"
import * as K from "@dashkite/katana/async"
import * as Posh from "@dashkite/posh"

import html from "./html"
import css from "./css"
    
class extends Rio.Handle

  hasSlot: ( name ) -> ( @slot name  )?

  slot: ( name ) -> @dom.querySelector "[slot='#{ name }']"

  Meta.mixin @, [
    Rio.tag "vellum-field"
    Rio.diff
    Rio.field
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
        # TODO this doesn't work because we haven't rendered yet
        #      so no slots have been assigned
        #
        #      we could check the light DOM?
        #
        K.poke ( attributes, handle ) ->
          { 
            attributes...
            slots:
              input: handle.hasSlot "input"
              hint: handle.hasSlot "hint"
              error: handle.hasSlot "error"
          }
        K.peek ( attributes ) ->
          console.log { attributes }
        Rio.render html
      ]
    ]
  ]
