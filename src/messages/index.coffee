import * as Meta from "@dashkite/joy/metaclass"
import * as Fn from "@dashkite/joy/function"
import * as Text from "@dashkite/joy/text"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import * as K from "@dashkite/katana/async"
import Registry from "@dashkite/helium"

import html from "./html"
import css from "./css"

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
    @messages ?= await Registry.get "messages"
    message = await @messages.queue.dequeue()
    message.content ?= @expand message
    message.type ?= "info"
    message

  expand: ({ code, parameters }) ->
    Text.interpolate @messages.catalog[ code ], ( parameters ? {} )

  Meta.mixin @, [
    R.tag "vellum-messages"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]
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