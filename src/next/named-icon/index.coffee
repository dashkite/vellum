import * as Fn from "@dashkite/joy/function"
import { shadowed, renderable, styleable } from "@dashkite/wayland"
import { component, icons } from "@dashkite/posh"
import Registry from "@dashkite/registry"

import html from "./html"

class extends do Fn.pipe [
    shadowed, renderable, styleable ]

  @tag "named-icon"

  @sheets [
    component
    icons
    css
  ]

  @connect ->
    messages = await Register.get "messages"
    name = @dom.getAttribute "name"
    icon = if messages.has [ "icons", name ]
      messages.get [ "icons", name ]
    else
      name
    @render html { icon }

  
