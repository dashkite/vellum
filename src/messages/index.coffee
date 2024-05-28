import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as Meta from "@dashkite/joy/metaclass"
import * as Obj from "@dashkite/joy/object"
import * as Text from "@dashkite/joy/text"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import * as K from "@dashkite/katana/async"
import Registry from "@dashkite/helium"

import html from "./html"
import css from "./css"

messages = undefined

dequeue = ->
  messages ?= await Registry.get "messages"
  await messages.queue.dequeue()

normalize = generic name: "vellum-messages.normalize"

generic normalize,
  Type.isString,
  ( content ) -> { content, type: "info" }

generic normalize,
  Obj.has "content"
  ({ content, type }) ->
    type ?= "info"
    { content, type }

expand = generic name: "vellum-messages.expand"

generic expand,
  Obj.has "code"
  ({ code, rest... }) ->
    message = normalize messages.catalog[ code ]
    expand { message..., rest... }

# when we have an error object
generic expand,
  Obj.has "message"
  ({ message }) ->
    expand
      code: do message.toLowerCase
      type: "failure"

generic expand,
  Obj.has "content"
  ({ content, type, parameters }) ->
    parameters ?= {}
    content = Text.interpolate content, parameters
    { content, type }

show = Fn.flow [
  R.call -> @next()
  R.render html
]

clear = Fn.flow [
  K.push -> {}
  R.render html
]

class extends R.Handle

  next: -> 
    message = await dequeue()
    expand message

  Meta.mixin @, [
    R.tag "vellum-messages"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component, Posh.icons ]
      # after each animation ends, get the next message
      R.event "animationend", [
        Fn.flow [
          clear
          show
        ]
      ] 
      clear
      show
    ] 
  ]