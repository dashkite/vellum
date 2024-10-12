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

isProse = ({ type }) ->
  ( type == "prose" )

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
    HTML.textarea { part: "editor", name, required }, value

generic input,
  isEnumerable,
  ({ name, value, required, disabled, 
    state, options, specifier... }) ->
    if options.children.length > 6
      HTML.tag "vellum-autocomplete",
        name: name
        value: value ? specifier.default
        disabled: disabled
        data: state: state ? "closed"
        for option in options.children
          HTML.div slot: "option", data: value: option.value, [
            HTML.span Format.title option.label
          ]
    else
      for option from options.children
        HTML.label [
          HTML.input { 
            name, type: "radio", 
            value: option.value
            required
            checked: value == option.value
          }
          HTML.span option.label
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
      HTML.input { 
        name
        type: "checkbox"
        value: if value then "on" else "off" 
      }
      HTML.slot name: "option"
    ]

generic input,
  isRange,
  ({ label, name, value, options }) ->

    value ?= 0
    HTML.div [

      HTML.slot name: "options"

      HTML.input
        name: name
        type: "range"
        value: value
        min: 0
        max: options?.children.length - 1
        list: options?.id


    ]

export default input
