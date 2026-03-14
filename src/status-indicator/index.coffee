import * as Fn from "@dashkite/joy/function"
import * as Time from "@dashkite/joy/time"
import Registry from "@dashkite/registry"
import {
  shadowed, renderable
  styleable, reactive
  eventful
} from "@dashkite/wayland"
import { component, icons, compact } from "@dashkite/posh"

import EventReactor from "@dashkite/reactive/event-reactor"

import html from "./html"
import css from "./css"

types = [ "network", "local" ]

class extends do Fn.pipe [
    shadowed, renderable
    styleable, reactive
    eventful
  ]

  @tag "status-indicator"

  @sheets [
    component
    icons
    compact
    css
  ]

  @reactor ( reactor ) ->

    inbox = await Registry.get "message bar inbox"
    channel = inbox.subscribe()

    yield from EventReactor
      .make reactor
      .bind @
      .forward "*"
      .when "connect", ->
        @render html()
        loop
          loop
            message = await channel.receive()
            break if message.name in types
          @render html message
