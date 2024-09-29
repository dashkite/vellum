import HTML from "@dashkite/html-render"
import input from "./input"

template = ( specifier ) ->

  { name, type, subtype, hint } = specifier
  
  classes = if subtype?
    "#{ subtype } #{ type } field" 
  else 
    "#{ type } field "

  HTML.main class: classes, [

    HTML.label [

      if hint?
        HTML.details class: "hint", [
          HTML.summary [ HTML.slot name: "label" ]
          HTML.div [ HTML.slot name: "hint" ]
        ]
      else
        HTML.div [ HTML.slot name: "label" ]

      if specifier.input?
        HTML.slot name: "input"
      else
        input specifier
      
      HTML.div class: "error",
        if specifier.error? 
          [
            HTML.i class: "ri-error-warning-line"
            HTML.slot name: "error"
          ]
    ]
  ]

export default template