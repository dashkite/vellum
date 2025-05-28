import * as Fn from "@dashkite/joy/function"
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

    yield from EventReactor
      .make reactor
      .bind @
      .forward "*"
      .when "connect, next", ( event ) ->
        @render html()
        message = await inbox.dequeue()
        @render html message
