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

    if specifier.hint?
      HTML.div id: "hint", popover: "hint", [
        Render.option "hint", specifier
      ]

    HTML.div [

      HTML.label for: "input", [
        Render.option "label", specifier
      ]

      if specifier.hint?
        HTML.button type: "button", popovertarget: "hint", 
          HTML.tag "named-icon", name: "information"

    ]
  
    if specifier.input?
      HTML.slot name: "input"
    else
      HTML.input
        id: "input"
        name: specifier.name
        type: specifier.type
        value: specifier.value
        required: specifier.required
        disabled: specifier.disabled
        pattern: specifier.pattern
        placeholder: specifier.placeholder

    # admonition
    if specifier.error?
      HTML.div class: "error", [
        HTML.tag "named-icon", name: "error"
        Render.option "error", specifier
      ]
    else HTML.div()
  ]

export default template