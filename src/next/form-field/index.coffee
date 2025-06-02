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
          @dom.value = host.attributes.value
          @render html { host.attributes..., host.slots... }
      yield event
    return

  @input()
    .intercept()
    .apply -> @dispatch "input", detail: @dom

  @change()
    .intercept()
    .apply ( event ) ->
      @dom.setValidity event.target.validity,
        event.target.validationMessage, event.target
      @dom.value = event.target.value
      @dispatch "change", detail: @dom
