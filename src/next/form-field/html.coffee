import * as Arr from "@dashkite/joy/array"
import * as It from "@dashkite/joy/iterable"
import Generic from "@dashkite/generic"
import HTML from "@dashkite/domo"

Render =
  
  classes: ( specifier ) ->
    result = "field"
    if specifier.type?
      result += " #{ specifier.type }"
    result

  # renders a slot or a span depending on whether
  # a corresponding slotted node exists
  option: do ->

    ( Generic.make "<private> Render.option" )

      .define [ String, Object ], ( name, specifier ) ->
        Render.option name, specifier[ name ]

      .define [ String, undefined ], ( name ) ->
        console.warn "form-field:
          no value specified for #{ name }"

      .define [ String, Node ], ( name ) ->
        HTML.slot { name }

      .define [ String, String ], ( _, text ) ->
        HTML.span text

template = ( specifier ) ->

  HTML.main class: ( Render.classes specifier ), [

    HTML.label [

      # hint, which falls back to just the label if none is
      # provided
      if specifier.hint?
        HTML.details class: "hint", [
          HTML.summary [ Render.option "label", specifier ]
          HTML.div [ Render.option "hint", specifier ]
        ]
      else
        Render.option "label", specifier

      # the input, either via slot or render a simple input
      if specifier.input?
        HTML.slot name: "input"
      else
        HTML.input
          name: specifier.name
          type: specifier.type
          value: specifier.value
          required: specifier.required
          disabled: specifier.disabled
          pattern: specifier.pattern
          placeholder: specifier.placeholder

      # error message for this field, if any
      HTML.div class: "error",
        if specifier.error?
          [
            HTML.i class: "ri-error-warning-line"
            Render.option "error", specifier
          ]

    ]      
  ]

export default template