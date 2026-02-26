import * as Fn from "@dashkite/joy/function"
import $ from "@dashkite/zest"
import { 
  shadowed, field, renderable, styleable, 
  reactive, eventful, observable
} from "@dashkite/wayland"
import { component, forms, icons } from "@dashkite/posh"

import events from "./events"
import html from "./html"
import css from "./css"

class extends do Fn.pipe [
    shadowed, field, renderable, styleable, 
    reactive, observable, events
  ]

  @tag "form-autocomplete"

  @sheets [ component, forms, icons, css ]

  @observe.attributes [ 
      "name", "value"
      "required", "disabled"
      "placeholder"
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
