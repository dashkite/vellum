import * as Type from "@dashkite/joy/type"
import * as Arr from "@dashkite/joy/array"
import * as It from "@dashkite/joy/iterable"
import Generic from "@dashkite/generic"
import HTML from "@dashkite/html-render"
import _input from "./input"

Render =

  slot: ( name, value ) ->
    if Type.isKind String, value
      HTML.span value
    else
      HTML.slot { name }

  label: ( specifier ) ->
    if specifier.hint?
      Render.hint specifier
    else
      Render.slot "label", specifier.label

  hint: ( specifier ) ->
    HTML.details class: "hint", [
      HTML.summary [
        Render.slot "label", specifier.label
      ]
      HTML.div [
        Render.slot "hint", specifier.hint
      ]
    ]

  input: ( specifier ) ->
    if specifier.input?
      HTML.slot name: "input"
    else
      _input specifier


  error: ( specifier ) ->
    HTML.div class: "error",
      if specifier.error?
        [
          HTML.i class: "ri-error-warning-line"
          Render.slot "error", specifier.error?
        ]

template = ( specifier ) ->

  classes = It.join " ", 
    Arr.compact [ 
        specifier.type
        specifier.subtype
        "field" 
      ]

  HTML.main class: classes, [

    HTML.label [

      Render.label specifier
      Render.input specifier
      Render.error specifier

    ]      
  ]

export default template