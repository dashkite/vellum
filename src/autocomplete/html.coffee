import HTML from "@dashkite/html-render"

template = ({ name, value }) ->
  HTML.main [
    HTML.input
      name: name
      type: "text"
      value: value
      autocomplete: "off"
    HTML.slot name: "preview"
    HTML.div class: "options", [
      HTML.slot name: "option"
    ]
  ]

export default template