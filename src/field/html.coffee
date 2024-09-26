import HTML from "@dashkite/html-render"
import input from "./input"

template = ({ name, type, subtype, required, disabled, value, options, slots }) ->
  
  classes = if subtype?
    "#{ subtype } #{ type } field" 
  else 
    "#{ type } field "

  HTML.main class: classes, [

    HTML.label [

      if slots.hint
        HTML.details class: "hint", [
          HTML.summary [ HTML.slot name: "label" ]
          HTML.div [ HTML.slot name: "hint" ]
        ]
      else
        HTML.slot name: "label"

      if slots.input
        HTML.slot name: "input"
      else
        input { name, type, subtype, required, disabled, value, options }

      HTML.div class: "error", [
        if slots.error
          HTML.i class: "ri-error-warning-line"
        HTML.span [ HTML.slot name: "error" ]
      ]
    
    ]
  ]

export default template