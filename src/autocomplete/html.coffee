import HTML from "@dashkite/html-render"

template = ({ name, value, disabled }) ->

  HTML.main [
    HTML.input
      name: name
      type: "text"
      value: value
      autocomplete: "off"
      disabled: disabled
    HTML.div part: "options", [
      HTML.slot name: "option"
    ]
  ]

export default template