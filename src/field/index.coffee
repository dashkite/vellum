import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Obj from "@dashkite/joy/object"
import * as DOM from "@dashkite/dominator"
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
        K.read "handle"
        K.peek ( handle ) ->
          if ( input = handle.root.querySelector "input, textarea" )?
            handle.dom.setValidity input.validity,
              input.validationMessage, input
      ]

      Rio.mutate [
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

      Rio.event "input", [
        Rio.intercept
        K.peek ( event, handle ) ->
          handle.dispatch "input", detail: handle.dom
      ]

      Rio.event "change", [
        Rio.intercept
        K.peek ( event, handle ) ->
          handle.dom.setValidity event.target.validity,
            event.target.validationMessage, event.target
          handle.dom.value = switch event.target.type
            when "checkbox" 
              if event.target.checked then "on" else "off"
            else event.target.value
          handle.dispatch "change", detail: handle.dom
      ]

    ]

    Rio.field
  ]
