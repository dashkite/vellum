import * as Meta from "@dashkite/joy/metaclass"
import * as K from "@dashkite/katana/async"
import * as Rio from "@dashkite/rio"
import * as Posh from "@dashkite/posh"

import events from "./events"
import html from "./html"
import css from "./css"

# TODO The value and the input are different.
#      The value should be based on the value
#      parameter for the option.

Value =
  set: K.peek ({ value }, handle ) -> 
    # handle.dom.value = if value? then value else ""
    if ( input = handle.root.querySelector "input" )?
      input.value = handle.dom.value

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

      Rio.activate [
        Rio.description
        Rio.dom
        Rio.attributes
        K.poke ( attributes, description ) ->
          {  attributes..., description... }
        Rio.render html
      ]

      # when the value is changed, we need to re-render
      Rio.modify [ "value" ], [
        Value.set
        Rio.render html        
        # changing the attributes doesn't actually change
        # the element's value, so we handle that here
      ]
    ]

    Rio.field
    events

  ]