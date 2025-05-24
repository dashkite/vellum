import $ from "@dashkite/zest"

Options =

  list: ( handle ) ->
    ( $ handle.root )
      .slotted
      .named "option"

  selected: ( handle ) ->
    Options
      .list handle
      .classes
      .contains "selected"
      .first

  first: ( handle ) ->
    Options
      .list handle
      .at 0

  target: ( handle, event ) ->
    slotted = Options.list handle
    event
      .composedPath()
      .find ( el ) -> el in slotted.elements

  scroll: ( handle ) ->
    handle
      .root
      .querySelector "[part='options']"
      .scrollIntoView
        behavior: "smooth"
        block: "end"

  set: ( selected, handle ) ->
    handle.dom.value = selected.dataset.value
    input = handle.root.querySelector "input"
    # input.value = handle.dom.value
    # handle.dispatch "input", handle.dom.value
    handle.dispatch "input", input.value
  
  change: ( selected, handle ) ->
    handle.dom.dataset.state = "closed"
    Options.set selected, handle
    input = handle.root.querySelector "input"
    handle.dispatch "change", input.value

  clear: ( selected, handle ) ->
    handle.dom.dataset.state = "closed"
    handle.dom.value = ""
    input = handle.root.querySelector "input"
    input.value = ""

export default Options