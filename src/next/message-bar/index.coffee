import * as Fn from "@dashkite/joy/function"
import Registry from "@dashkite/registry"
import {
  shadowed, renderable
  styleable, reactive
  eventful
} from "@dashkite/wayland"
import { component, icons, compact } from "@dashkite/posh"

import html from "./html"
import css from "./css"

class extends do Fn.pipe [
    shadowed, renderable
    styleable, reactive
    eventful
  ]

  @tag "message-bar"

  @sheets [
    component
    icons
    compact
    css
  ]

  @listen "animationend"
    .matches ".container"
    .send "next"

  @reactor ( reactor ) ->

    messages = await Registry.get "messages"
    inbox = await Registry.get "message bar inbox"

    for await event from reactor
      switch event.name
        when "connect", "next"
          @render html()
          message = await inbox.dequeue()
          @render html message
      yield event
    return

