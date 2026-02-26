import HTML from "@dashkite/domo"

template = ({ name, value, required, disabled, placeholder }) ->
  HTML.main [
    HTML.input
      name: name
      type: "text"
      value: value
      autocomplete: "off"
      disabled: disabled
      required: required
      placeholder: placeholder
    HTML.div part: "options", [
      HTML.slot name: "option"
    ]
    HTML.slot name: "status"
  ]

export default template