import * as Fn from "@dashkite/joy/function"
import $ from "@dashkite/zest"
import { 
  shadowed, field, renderable, styleable, 
  reactive, eventful, observable
} from "@dashkite/wayland"
import { component, forms, icons } from "@dashkite/posh"

import css from "./css"
import html from "./html"

class extends do Fn.pipe [
    shadowed, field, renderable, styleable, 
    reactive, eventful, observable
  ]

  @tag "form-field"

  @sheets [
    component, forms
    icons, css
  ]

  @observe.attributes [ 
    "name", "type", "value"
    "required", "disabled"
    "label", "hint", "error"
    "pattern", "placeholder"
  ]

  @reactor ( reactor ) ->
    for await event from reactor
      switch event.name
        when "connect", "modify"
          host = $ @dom          
          shadow = $ @shadow
          @dom.value = host.attributes.value
          @render html { host.attributes..., host.slots... }
          # TODO what to do with slotted input
          # TODO sync the @dom value property with the input value property
          # TODO how much of this can be moved into the field mixin?
          if ( input = ( shadow.query "input" ).first )?
            input.value = @dom.value
            @dom.setValidity input.validity, 
              input.validationMessage, input
      yield event
    return

  @input()
    .apply ( event ) ->
      @dom.setValidity event.target.validity,
        event.target.validationMessage, event.target
      @dom.value = event.target.value

  # `change` events do not cross shadow boundaries
  @change()
    .intercept()
    .apply ( event ) ->
      @dispatch "change", detail: @dom
