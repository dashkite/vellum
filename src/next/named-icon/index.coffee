import * as Fn from "@dashkite/joy/function"
import HTML from "@dashkite/domo"
import { shadowed, renderable, styleable } from "@dashkite/wayland"
import { component, icons } from "@dashkite/posh"
import Registry from "@dashkite/registry"

class extends do Fn.pipe [
    shadowed, renderable, styleable ]

  @tag "named-icon"

  @sheets [
    component
    icons
  ]

  @connect ->
    messages = await Registry.get "messages"
    console.log { messages }
    name = @dom.getAttribute "name"
    icon = if messages.has [ "icons", name ]
      messages.get [ "icons", name ]
    else
      name
    @render HTML.i class: "ri-#{ icon }"

  
