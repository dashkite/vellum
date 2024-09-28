import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import HTML from "@dashkite/html-render"

import * as Fn from "@dashkite/joy/function"
import * as Text from "@dashkite/joy/text"

Format =
  title: Fn.pipe [
    Text.uncase
    Text.titleCase
  ]


isCustom = ({ type, html }) -> ( type == "custom" ) && html?

isMarkdown = ({ type, subtype }) ->
  ( type == "markdown" ) && ( subtype == "prose" )

isProse = ({ type, subtype }) ->
  ( type == "text" ) && ( subtype == "prose" )

isEmail = ({ type, subtype }) ->
  ( type == "text" ) && ( subtype == "email" )

isURL = ({ type, subtype }) -> 
  ( type == "text" ) && ( subtype == "url" )

isEnumerable = ({ type, options }) -> 
  ( type.startsWith "enum" ) && ( options?.children? )

isBoolean = ({ type }) -> type == "boolean"

isRange= ({ type }) -> type == "range"

input = generic name: "Render.input"

generic input,
  Type.isObject,
  ({ name, value, type, required, disabled }) ->
    type ?= "text"
    HTML.input { name, value, type, required, disabled }

generic input,
  isCustom,
  ({ html }) -> html
   
generic input,
  isProse,
  ({ subtype, name, value, required, hints }) ->
    HTML.textarea {
      name, value, required, 
      class: "#{ subtype } #{ hints.length }"
    }

generic input,
  isEnumerable,
  ({ options, name, value, required, specifier... }) ->
    value ?= specifier.default ? ""
    # TODO check if enum is dynamic
    #      we could maybe use $from
    #      (non-standard, but none of
    # the standard things work)
    if options.length > 6
      HTML.select { name, value },
        for option in options
          HTML.option value: option, option
    else
      for option from options.children
        HTML.label [
          HTML.input { 
            name, type: "radio", 
            value: option.value
            required
            checked: value == option.value
          }
          HTML.span option.textContent
        ]

generic input,
  isEmail,
  ({ name, value, required }) ->
    value ?= ""
    HTML.input { name, value, type: "email", required }

generic input,
  isURL,
  ({ name, value, required, disabled }) ->
    value ?= ""
    HTML.input { name, value, type: "url", required, disabled }

generic input,
  isBoolean,
  ({ name, value }) ->
    value ?= false
    HTML.label [
      HTML.input { name, type: "checkbox", checked: value }
      HTML.slot name: "option"
    ]

generic input,
  isRange,
  ({ label, name, options, value }) ->
    value ?= options.children[0]
    HTML.div [
      HTML.slot name: "options"
      HTML.input
        name: name
        type: "range"
        min: 0
        max: options.children.length - 1
        value: value
        list: options.id
    ]

export default input
